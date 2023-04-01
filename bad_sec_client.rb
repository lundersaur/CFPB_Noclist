require 'uri'
require 'net/http'
require 'digest'
require 'json'

class BadSecClient
  BADSEC_URI = "http://0.0.0.0:8888"

  def run
    STDOUT.puts(fetch_users)
  end

  def get_auth_token
    uri = URI("#{BADSEC_URI}/auth")
    auth_token = nil

    1.upto(3) do
      response = Net::HTTP.get_response(uri)
      if response.code == "200"
        auth_token = response['badsec-authentication-token']
        break
      else
        sleep 1
      end
    end

    exit 1 unless auth_token
    return auth_token
  end

  def checksum(auth_token, request_path)
    Digest::SHA256.hexdigest(auth_token + request_path)
  end

  def fetch_users
    token = get_auth_token
    users_list = nil
    uri = URI.parse("#{BADSEC_URI}/users")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["X-Request-Checksum"] = checksum(token, '/users')

    1.upto(3) do
      response = http.request(request)
      if response.code == "200"
        users_list = JSON.generate(response.body.split)
        break
      else
        sleep 1
      end
    end

    exit 1 unless users_list
    return users_list
  end
end

BadSecClient.new.run