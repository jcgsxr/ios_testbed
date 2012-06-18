require 'bundler/setup'
require 'sinatra'
require 'json'
require 'pp'
require 'APNS'

APNS.pem = File.join(File.dirname(__FILE__), "..", "keys", "certAndKey.pem")
APNS.host = 'gateway.push.apple.com'

STATE_FILE = "state.json"

REGISTRATIONS = File.exists?(STATE_FILE) ? JSON.parse(File.read(STATE_FILE)) : []

at_exit do
  STDERR.puts "SAVING STATE"
  File.open("state.json", "w") { |f| f.puts JSON.generate(REGISTRATIONS) }
end

enable :logging

# Local support stuff

get '/' do
  [200, { "Content-Type" => "text/html" }, "<html><a style='font-size: 200px;' href='/pass'>GET PASS</a>"]
end

get '/pass' do
  [200, { "Content-Type" => "application/vnd.apple.pkpass" }, File.read("../test.pkpass")]
end

get '/pushes' do
  @regs = REGISTRATIONS
  erb :pushes
end

post '/push/:token' do
  APNS.send_notification(params[:token], :aps => { :alert => "" } )
  [200, { "Content-Type" => "text/html"}, "Post succeeded!"]
end


# APPLE API

post '/register/v1/devices/:device/registrations/:identifier/:serial_number' do
  data = JSON.parse(request.body.read)
  token = data["pushToken"]

  d = [params[:device], params[:serial_number], token]
  return [200, {}, ""] if REGISTRATIONS.include? d

  REGISTRATIONS << d
  puts "Registered new pass: #{d}"
  [201, {}, ""]
end

delete '/register/v1/devices/:device/registrations/:identifier/:serial_number' do
  puts "Got DELETE request from #{params[:device]} id: #{params[:identifier]} SN: #{params[:serial_number]}"
  device = params[:device]
  sn = params[:sn]

  existing_regs = REGISTRATIONS.select { |x| x[0] == device && x[2] == sn }
  return [401, {}, ""] if existing_regs.length == 0

  puts "Unregistering registrations: #{existing_regs}"
  existing_regs.each { |r| REGISTRATIONS.delete r }
  [200, {}, ""]
end

get '/register/v1/devices/:device/registrations/:identifier' do
  existing_regs = REGISTRATIONS.select { |x| x[0] == params[:device] }
  serialNumbers = existing_regs.map { |x| x[1] }

  data = { "lastUpdatedTag" => Time.now.to_s,
            "serialNumbers" => serialNumbers
         }
  [200, { "Content-Type" => "application/json"}, JSON.generate(data)]
end

get '/register/v1/passes/:identifier/:serial_number' do
  [200, { "Content-Type" => "application/vnd.apple.pkpass" }, File.read("../test.pkpass")]
end

