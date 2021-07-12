# frozen_string_literal: true

module Demio
  class Client
    module Event
      # Fetches a single event from Demio
      #
      # @param id [String]
      # @param active [Boolean]
      # @return [Net::HTTPOk]
      def event(id, active = nil)
        active_param = active ? "?active=#{active}" : nil
        get "event/#{id}#{active_param}"
      end
    end
  end
end
