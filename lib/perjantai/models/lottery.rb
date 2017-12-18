module Perjantai
  module Models
    class Lottery
      def initialize(id)
        @id = id
      end

      def to_h
        {
          id: @id,
          name: @name
        }
      end

      def append_event(event)
        case event
        when Events::LotteryCreated
          @name = event[:name]
        end
      end
    end
  end
end
