require 'rotary/version'
require 'rotary/storage'
require 'rotary/serializer'

module Rotary
  SERIALIZER = :marshal
  STORAGE = :redis
  LIMIT = 100
  PREFIX = 'rotary'
  TTL = nil # must be nil or seconds

  class OverflowError < Exception; end

  def self.pool(**options)
    Pool.new(**options)
  end

  class Pool
    def initialize(
      storage: STORAGE,
      connection: nil,
      serializer: SERIALIZER,
      limit: LIMIT,
      ttl: TTL,
      prefix: PREFIX,
      on_overflow: ->(obj) { raise OverflowError },
      create: create
    )
      @limit = limit
      storage_options = connection ? { connection: connection } : {}
      @create_obj = create
      @on_overflow = on_overflow
      storage = Rotary::Storage.load_storage(storage)
      @serializer = Rotary::Serializer.load_serializer(serializer)
      @storage = storage.new(
        connection: connection || storage.default_connection,
        ttl: ttl,
        serializer: @serializer,
        prefix: prefix
      )
    end

    def get
      @storage.pop || @create_obj.call
    end

    # block should return object, because object could've been mutated
    def with
      object = get
      object = yield(object)
      set(object)
    end

    def size
      @storage.size
    end

    def clear
      @storage.clear
    end

    def set(obj)
      return @on_overflow.call(obj) if @limit && @storage.size >= @limit
      @storage.push(obj)
    end

    # Removes all elements from pool, which means specified by block
    # argument criteria.
    def clean_older_than(n, &block)
      if @storage.respond_to?(:clean_older_than)
        @storage.clean_older_than(n, &block)
      else
        fail "#{@storage.class}#clean_where not implemented"
      end
    end
  end
end
