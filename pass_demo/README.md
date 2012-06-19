Generate your keys.
 
* Make sure you imported the generated Pass certificate from the ADC
* Select both the cert and the private key in Keychain
* Export as cert.p12
 
* Run the following inside the extracted dir:
 
openssl pkcs12 -in PassKitCertificates.p12 -out keys/certAndKey.pem -nodes -clcerts
openssl pkcs12 -in PassKitCertificates.p12 -clcerts -nokeys -out keys/certificate.pem
openssl pkcs12 -in PassKitCertificates.p12 -nocerts -out keys/key.pem

///////////////////////// OLD AND REPLACED BUT HERE FOR REFERENCE /////////////////////////////////////////
openssl pkcs12 -in PassKitCertificates.p12 -clcerts -nokeys -out keys/certificate.pem
openssl pkcs12 -in PassKitCertificates.p12 -nocerts -out keys/key.pem
openssl smime -binary -sign -signer keys/certificate.pem -inkey keys/key.pem -in payload/manifest.json -out signature -outform DER
///////////////////////// OLD AND REPLACED BUT HERE FOR REFERENCE /////////////////////////////////////////

(you should now have payload/ keys/ and serve/)
 
* Note the password you entered for the last key.
 
* Update payload/pass_template.json with your information
* Enter the password you just made with openssl on the second to last line of bundle.rb
 
You should now be able to run 'ruby bundle.rb' to create a valid test.pkpass.
 
 
# The website
 
There's also a sample site included in this package, which will allow you to download the generated pass, see a list of registered passes, and push an update to passes.
 
* Make sure you have bundler installed: "sudo gem install bundler". You might need Ruby 1.9.3 for the site to work.
 
* cd serve
* bundle install --path=vendor
* bundle exec thin start --port=4567
 
you should now be able to go the http://localhost:4567.
 
* Try the same on your iOS device, using your dev machine's ip.
* Click the "get pass" link. You should get your pass. If tehre's something wrong, check the console in Xcode.
 
* Set "allow http service" option in Settings/Development on your iOS device.
* Make sure you entered the web service url correctly in pass_template.json.
* Regenerate the pass with ruby bundle.rb if necessary.
* Download the pass and add it to passbook while the server is running.
* You should see a GET request coming in which registers the pass.
* You can now go to http://localhost:4567/pushes to get a list of registered passes
* Press the link to send a push notification.
 
* You should see a new GET for the pass come in on the server.
 
Testing push notifications:
 
* Change the Balance var in bundle.rb
* Regenerate the bundle
* Send a push notification
 
You should now see something like "Balance updated to XXX" appear on the device.