# frozen_string_literal: true

module Demio
  class Client
    module EventDate
      # Fetches info about a specific date from Demio
      #
      # @param id [String]
      # @param date_id [String]
      # @return [Net::HTTPCreated]
      def event_date(id, date_id)
        get "event/#{id}/#{date_id}"
      end
    end
  end
end
