# frozen_string_literal: true

module Demio
  class Client
    module Participants
      # Returns Event Date participants list
      #
      # @param event_date_id [String]
      # @return [Net::HTTPOk]
      def participants(event_date_id)
        get "report/#{event_date_id}/participants"
      end
    end
  end
end
