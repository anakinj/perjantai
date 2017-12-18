module Perjantai
  module Commands
    class CreateLottery
      def initialize(data)
        @data = data
      end

      def execute!
        id = SecureRandom.uuid
        chain = EventChain.new(id)
        chain.add_link(@data.merge(type: Events::LotteryCreated.name))
        id
      end
    end
  end
end
