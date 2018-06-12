require "demio/event"
require "demio/events"
require "demio/event_date"
require "demio/register"
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

    def initialize(api_key, api_secret)
    end

    def get
    end

    def put
    end

    private

    def base_url
      "https://my.demio.com/api/v1/event/"
    end
  end
end
