# frozen_string_literal: true

module Demio
  class Client
    module Events
      # Fetches all events from Demio
      #
      # @return [Net::HTTPCreated]
      def events
        get "events"
      end
    end
  end
end
