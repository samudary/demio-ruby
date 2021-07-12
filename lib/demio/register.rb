# frozen_string_literal: true

module Demio
  class Client
    module Register
      # Adds a registrant to an event in Demio
      # Docs: https://publicdemioapi.docs.apiary.io/#reference/events/register/register
      #
      # @param payload [Hash]
      # @return [Net::HTTPCreated]
      def register(payload = {})
        put "event/register", payload
      end
    end
  end
end
