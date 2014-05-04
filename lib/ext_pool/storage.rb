require 'ext_pool/storage/memory'
require 'ext_pool/storage/redis'

module ExtPool
  module Storage

    class Error < Exception
    end

    class << self
      def load_storage(storage, connection: nil)
        options = connection ? { connection: connection } : {}
        storage_backend = load_const(storage)
        storage_backend.new(**options)
      end

      protected

      def load_const(storage)
        const_get("ExtPool::Storage::#{storage.capitalize}")
      rescue NameError
        raise ExtPool::Storage::Error,
          "Wrong storage #{storage} of class #{storage.class}"
      end
    end
  end
end
