module Demio
  class Client
    module Event
      def event(id)
        get "event/#{id}"
      end
    end
  end
end
