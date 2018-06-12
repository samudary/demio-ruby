module Demio
  class Client
    module EventDate
      def event_date(id, date_id)
        get "event/#{id}/date/#{date_id}"
      end
    end
  end
end