# frozen_string_literal: true

module Demio
  class Client
    module Events
      # Fetches all events from Demio
      #
      # @param type [String]
      # @return [Net::HTTPOk]
      def events(type = nil)
        type_param = type ? "?type=#{type}" : nil
        get "events#{type_param}"
      end
    end
  end
end
