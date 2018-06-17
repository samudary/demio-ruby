# frozen_string_literal: true

module Demio
  class Client
    module Event
      # Fetches a single event from Demio
      #
      # @param id [String]
      # @return [Net::HTTPCreated]
      def event(id)
        get "event/#{id}"
      end
    end
  end
end
