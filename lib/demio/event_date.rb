# frozen_string_literal: true

module Demio
  class Client
    module EventDate
      # Fetches info about a specific date from Demio
      #
      # @param event_id [String]
      # @param event_date_id [String]
      # @return [Net::HTTPOk]
      def event_date(event_id, event_date_id)
        get "event/#{event_id}/date/#{event_date_id}"
      end
    end
  end
end
