require 'rotary/storage/memory'
require 'rotary/storage/redis'

module Rotary
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
        const_get("Rotary::Storage::#{storage.capitalize}")
      rescue NameError
        raise Rotary::Storage::Error,
          "Wrong storage #{storage} of class #{storage.class}"
      end
    end
  end
end
