# This storage method is not threadsafe
module Rotary
  module Storage
    class Memory
      def initialize(*)
        clear
      end

      def push(session)
        @storage.unshift(session)
        self
      end

      def pop
        @storage.pop
      end

      def size
        @storage.size
      end

      def clear
        @storage = []
      end

      # just to make it compatible
      def self.default_connection
        self
      end
    end
  end
end
