module ExtPool
  module Storage
    class Memory
      def initialize
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
    end
  end
end
