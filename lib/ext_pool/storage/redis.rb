require 'digest/sha1'

module ExtPool
  module Storage
    class Redis
      class Retry < Exception
      end

      def initialize(
        connection: Redis.new,
        prefix: "ext",
        ttl: nil,
        serializer: serializer
      )
        @redis = connection
        @prefix = "#{prefix}::"
        @ttl = ttl # in seconds
        @pool_list = "#{@prefix}pool"
        @size = size
        @serializer = serializer
      end

      def push(obj)
        serialized = @serializer.dump(obj)
        # TODO: make lpush + set/expire transactional somehow
        @redis.lpush(@pool_list, serialized)
        if @ttl
          key = ttl_key(serialized)
          @redis.multi do
            @redis.set(key, 1)
            @redis.expire(key, @ttl)
          end
        end
        self
      end

      def pop
        serialized = @redis.rpop(@pool_list)
        obj = serialized ? @serializer.load(serialized) : nil
        return obj unless @ttl
        # TTL-only logic below
        key = ttl_key(serialized)
        raise Retry unless @redis.get(key)
        @redis.del(key)
        obj
      rescue Retry
        retry
      end

      def size
        @redis.llen(@pool_list)
      end

      def clear
        @redis.del(@pool_list)
      end

      protected

      def ttl_key(obj)
        "#{@prefix}#{Digest::SHA1.hexdigest(obj)}"
      end
    end
  end
end

