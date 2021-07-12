# frozen_string_literal: true

module Demio
  class Client
    module Participants
      # Returns Event Date participants list
      #
      # @param event_date_id [String]
      # @params status [String]
      # @return [Net::HTTPOk]
      def participants(event_date_id, status = nil)
        status_param = status ? "?status=#{status}" : nil
        get "report/#{event_date_id}/participants#{status_param}"
      end
    end
  end
end
