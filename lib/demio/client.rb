# frozen_string_literal: true

require "demio/errors"
require "demio/event"
require "demio/event_date"
require "demio/events"
require "demio/participants"
require "demio/register"
require "json"
require "net/http"
require "uri"

module Demio
  class Client
    include Event
    include EventDate
    include Events
    include Participants
    include Register

    attr_reader :api_key, :api_secret

    REQUEST_REDIRECT_FOLLOW_LIMIT = 10

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

    def make_request(verb_klass, uri, payload = {}, request_limit = REQUEST_REDIRECT_FOLLOW_LIMIT)
      raise TooManyRedirectsError, "too many HTTP redirects" if request_limit.zero?

      uri = redirected_request?(request_limit) ? URI(uri) : format_uri(uri)

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        response = http.request(create_request(verb_klass, uri, payload))
        handle_response(response, verb_klass, payload, request_limit)
      end
    end

    def create_request(verb_klass, uri, payload)
      request = verb_klass.new(uri)
      request = create_headers(request)
      request.body = payload.to_json if verb_klass == Net::HTTP::Put
      request
    end

    def handle_response(response, verb_klass, payload, request_limit)
      case response
      when Net::HTTPSuccess
        response
      when Net::HTTPRedirection
        location = response["Location"]
        make_request(verb_klass, location, payload, request_limit - 1)
      else
        response.value
      end
    end

    def create_headers(request)
      request["Api-Key"] = api_key
      request["Api-Secret"] = api_secret
      request["Content-Type"] = "application/json"
      request["User-Agent"] = "Demio Ruby Client - #{Demio::VERSION}"
      request
    end

    def redirected_request?(request_limit)
      request_limit < REQUEST_REDIRECT_FOLLOW_LIMIT
    end

    def format_uri(path)
      URI(base_uri + path)
    end

    def base_uri
      "https://my.demio.com/api/v1/"
    end
  end
end
