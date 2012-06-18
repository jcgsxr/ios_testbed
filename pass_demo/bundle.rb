#!/usr/bin/env ruby

require 'json'
require 'pp'

PAYLOAD="payload"
KEYS="keys"

# Remove old file
`rm -f #{PAYLOAD}/signature #{PAYLOAD}/manifest.json test.pkpass`

VARS = { "BALANCE" => 480.0, "SERIAL_NUMBER" => "1" }

# Parse json.pass to make sure it's valid and adjust variables
pass = JSON.parse(File.read("#{PAYLOAD}/pass_template.json"))

def fill_in (val)
  return VARS[val] || val if val.is_a? String
  return val.map { |x| fill_in x } if val.is_a? Array
  return Hash[val.map { |x,y| [x, fill_in(y)] }] if val.is_a? Hash
  return val
end

pass = fill_in pass

File.open("#{PAYLOAD}/pass.json", "w") { |f| f.print JSON.pretty_generate(pass) }

# Generate manifest
manifest = {}
Dir["#{PAYLOAD}/*"].each do |file|
  next if ["#{PAYLOAD}/manifest.json", "#{PAYLOAD}/signature"].include? file
  manifest[file.gsub(PAYLOAD + "/", "")] = `shasum #{file}`.strip.gsub(/ .*/, "")
end

File.open("#{PAYLOAD}/manifest.json", "w") { |f| f.puts JSON.pretty_generate manifest }

`openssl smime -binary -sign -passin "pass:YOURPASSKEY" -signer #{KEYS}/certificate.pem -inkey #{KEYS}/key.pem  -in #{PAYLOAD}/manifest.json -out #{PAYLOAD}/signature -outform DER`
`cd #{PAYLOAD} && zip -r ../test.pkpass *json *png signature`
