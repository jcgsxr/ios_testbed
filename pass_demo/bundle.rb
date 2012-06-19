#!/usr/bin/env ruby

require 'json'
require 'pp'

PAYLOAD="payload"
KEYS="keys"

# Remove old file
`rm -f #{PAYLOAD}/signature #{PAYLOAD}/manifest.json test.pkpass`

# Generate manifest
manifest = {}
Dir["#{PAYLOAD}/*"].each do |file|
  next if ["#{PAYLOAD}/manifest.json", "#{PAYLOAD}/signature"].include? file
  manifest[file.gsub(PAYLOAD + "/", "")] = `shasum #{file}`.strip.gsub(/ .*/, "")
end

File.open("#{PAYLOAD}/manifest.json", "w") { |f| f.puts JSON.pretty_generate manifest }

`openssl smime -binary -sign -signer #{KEYS}/certificate.pem -inkey #{KEYS}/key.pem -in #{PAYLOAD}/manifest.json -out #{PAYLOAD}/signature -outform DER`
`cd #{PAYLOAD} && zip -r ../test.pkpass *json *png signature`
