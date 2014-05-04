require 'ext_pool/version'
require 'ext_pool/storage'
require 'ext_pool/serializer'

module ExtPool

  SERIALIZER = ExtPool::Serializer::Marshal
  SIZE = 10

  class Pool

    def initialize(storage: :memory, serializer: SERIALIZER, size: SIZE, &block)
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
