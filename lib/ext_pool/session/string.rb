# Needed for testing. Acts as example.
module ExtPool
  module Session
    module String
      def initialize(value)
        @value = value
      end

      def store
        @value.to_s
      end
    end
  end
end

