require 'uri'
require 'net/http'
require 'digest'
require 'json'

class BadSecClient
  BADSEC_URI = "http://0.0.0.0:8888"

  def run
    STDOUT.puts("Call to users gives: " + fetch_users)
  end

  def get_auth_token
    uri = URI("#{BADSEC_URI}/auth")
    res = Net::HTTP.get_response(uri)
    token = res['badsec-authentication-token']
  end

  def checksum(auth_token, request_path)
    Digest::SHA256.hexdigest(auth_token + request_path)
  end

  def fetch_users
    token = get_auth_token
    uri = URI.parse("#{BADSEC_URI}/users")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["X-Request-Checksum"] = checksum(token, '/users')

    response = http.request(request).body
    JSON.generate(response.split)
  end
end

BadSecClient.new.run