require 'ext_pool/version'
require 'ext_pool/storage'
require 'ext_pool/serializer'

module ExtPool
  class Pool

    SERIALIZER = ExtPool::Serializer::Marshal

    def initialize(storage: :memory, serializer: SERIALIZER, size: 100, &block)
      @limit = limit
      define_method(:create, &block)
      ExtPool::Serializer.load_serializer(serializer)
    end

    def get
      @storage.get
    end

    def put
      @storage.put
    end
  end
end
