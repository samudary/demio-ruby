module Demio
  class Client
    module Events
      def events
        get "events"
      end
    end
  end
end