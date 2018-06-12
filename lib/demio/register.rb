module Demio
  class Client
    module Register
      def register(payload = {})
        put "event/register", payload
      end
    end
  end
end
