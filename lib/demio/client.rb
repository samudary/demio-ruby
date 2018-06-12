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

    def put(uri, payload)
      make_request(Net::HTTP::Put, uri, payload)
    end

    def ping
      make_request(Net::HTTP::Get, "ping")
    end

    private

    def make_request(verb_klass, uri, payload = {}, limit = 10)
      raise TooManyRedirectsError, "too many HTTP redirects" if limit == 0

      uri = format_uri(uri)

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = verb_klass.new uri
        request = set_headers(request)

        if verb_klass == Net::HTTP::Put
          request.body = payload.to_json
        end

        response = http.request request

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response["location"]
          make_request(verb_klass, location, payload, limit - 1)
        else
          response.value
        end
      end
    end

    def set_headers(request)
      request["Api-Key"] = api_key
      request["Api-Secret"] = api_secret
      request["Content-Type"] = "application/json"
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
