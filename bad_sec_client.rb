require 'uri'
require 'net/http'

class BadSecClient
  BADSEC_URI = "http://0.0.0.0:8888"

  def run
    STDOUT.puts(authenticate)
  end

  def authenticate
    uri = URI("#{BADSEC_URI}/auth")
    res = Net::HTTP.get_response(uri)
    token = res.body
  end
end

BadSecClient.new.run