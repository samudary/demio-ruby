require "demio/event"
require "demio/events"
require "demio/event_date"
require "demio/register"
require "demio/errors"
require "json"
require "net/http"
require "uri"

module Demio
  class Client
    include Event
    include Events
    include EventDate
    include Register

    attr_reader :api_key, :api_secret

    def initialize(options = {})
      @api_key = options[:api_key]
      @api_secret = options[:api_secret]
    end

    def get(uri)
      make_request(Net::HTTP::Get, uri)
    end

    def put(uri)
      make_request(Net::HTTP::Put, uri)
    end

    def ping
      make_request(Net::HTTP::Get, "ping")
    end

    private

    def make_request(verb_klass, uri, limit = 10)
      raise TooManyRedirectsError, "too manny HTTP redirects" if limit == 0

      uri = format_uri(uri)

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new uri
        request = set_headers(request)
        response = http.request request

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response["location"]
          make_request(:get, location, limit - 1)
        else
          response.value
        end
      end
    end

    def set_headers(request)
      request["Api-Key"] = api_key
      request["Api-Secret"] = api_secret
      request
    end

    def format_uri(path)
      URI(base_uri + path)
    end

    def base_uri
      "https://my.demio.com/api/v1/"
    end
  end
end
