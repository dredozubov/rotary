require 'ext_pool/version'
require 'ext_pool/storage'
require 'ext_pool/serializer'

module ExtPool

  SERIALIZER = :marshal
  STORAGE = :redis
  SIZE = 10

  class Pool

    def initialize(storage: STORAGE, connection: nil, serializer: SERIALIZER, size: SIZE, &block)
      @limit = limit
      storage_options = connection ? { connection: connection } : {}
      define_method(:create, &block)
      @serializer = ExtPool::Serializer.load_serializer(serializer)
      @storage = ExtPool::Storage.load_storage(storage, **storage_options)
    end

    def get
      @storage.pop
    end
  end
end
