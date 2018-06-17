module Demio
  class Client
    module Register
      # Adds a registrant to an event in Demio
      #
      # @param payload [Hash]
      # @return [Net::HTTPCreated]
      def register(payload = {})
        put "event/register", payload
      end
    end
  end
end
