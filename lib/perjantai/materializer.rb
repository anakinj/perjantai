module Perjantai
  module Materializer
    class << self
      def create(type, id)
        instance = type.new(id)
        EventChain.new(id).each do |event|
          event_instance = create_event_instance(event)
          instance.append_event(event_instance)
        end
        instance
      end

      def create_event_instance(event_data)
        const_get(event_data[:type]).new(event_data)
      end
    end
  end
end
