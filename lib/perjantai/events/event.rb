module Perjantai
  module Events
    class Event
      extend Forwardable

      def_delegators :@data, :[], :[]=

      def initialize(data = {})
        @data = OpenStruct.new(data)
      end
    end
  end
end
