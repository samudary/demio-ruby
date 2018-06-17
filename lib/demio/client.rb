# frozen_string_literal: true

require "demio/errors"
require "demio/event"
require "demio/event_date"
require "demio/events"
require "demio/register"
require "json"
require "net/http"
require "uri"

module Demio
  class Client
    include Event
    include EventDate
    include Events
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
      make_request(
        Net::HTTP::Get,
        "ping/query?api_key=#{api_key}&api_secret=#{api_secret}"
      )
    end

    private

    def make_request(verb_klass, uri, payload = {}, limit = 10)
      raise TooManyRedirectsError, "too many HTTP redirects" if limit.zero?

      uri = format_uri(uri)

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = verb_klass.new uri
        request = create_headers(request)

        request.body = payload.to_json if verb_klass == Net::HTTP::Put

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

    def create_headers(request)
      request["Api-Key"] = api_key
      request["Api-Secret"] = api_secret
      request["Content-Type"] = "application/json"
      request["User-Agent"] = "Demio Ruby Client - #{Demio::VERSION}"
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
