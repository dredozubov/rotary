module ExtPool
  module Storage
    module Memory
      storage = []

      def put(session)
        storage.unshift(session)
      end

      def get
        storage.pop
      end

    end
  end
end
