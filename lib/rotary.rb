require 'rotary/version'
require 'rotary/storage'
require 'rotary/serializer'

module Rotary

  SERIALIZER = :marshal
  STORAGE = :redis
  SIZE = 10

  class Pool

    def initialize(storage: STORAGE, connection: nil, serializer: SERIALIZER, size: SIZE, &block)
      @limit = limit
      storage_options = connection ? { connection: connection } : {}
      define_method(:create, &block)
      @serializer = Rotary::Serializer.load_serializer(serializer)
      @storage = Rotary::Storage.load_storage(storage, **storage_options)
    end

    def get
      @storage.pop
    end
  end
end
