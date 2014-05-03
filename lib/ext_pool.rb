require 'ext_pool/version'
require 'ext_pool/storage'
require 'ext_pool/serializer'

module ExtPool
  class Pool
    def initialize(storage: :memory, serializer: ExtPool::Serializer::Marshal, limit: 100)
      @limit = limit
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
