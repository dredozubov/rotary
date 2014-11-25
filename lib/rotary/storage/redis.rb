require 'digest/sha1'
require 'redis'

module Rotary
  module Storage
    class Redis
      DEFAULT_PREFIX = 'rotary'.freeze

      class Retry < Exception
      end

      def self.default_connection
        ::Redis.new
      end

      def initialize(connection:, ttl:, serializer:, prefix: DEFAULT_PREFIX)
        @redis = connection
        @ttl = ttl # in seconds
        @prefix = "#{prefix}::"
        @serializer = serializer
        @pool_list = "#{@prefix}pool"
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
        if obj
          # TTL-only logic below
          key = ttl_key(serialized)
          raise Retry unless @redis.get(key)
          @redis.del(key)
        end
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

      # Removes sessions, where ttl is bigger than threshold n.
      def clean_older_than(n)
        # It doesn't have to happen atomically.
        # New session will be lpush'ed, we can easily check only
        # N sessions from the right.
        size.times do
          serialized_session = @redis.rpop(@pool_list)

          # We have no sessions left. It can happen.
          break unless serialized_session

          key = ttl_key(serialized_session)
          ttl_marker = @redis.ttl(key)

          # redis.rb returns -2 when key doesn't exist
          no_ttl = ttl_marker == -2
          next if no_ttl

          old = @ttl ? ttl_marker < (@ttl - n) : false
          if old
            # delete ttl key
            @redis.del(key)
            # and execute the block with session as arg
            session = @serializer.load(serialized_session)
            yield(session) if block_given?
          else
            # push back from the left side
            @redis.lpush(@pool_list, serialized_session)
          end
        end
      end

      protected

      def ttl_key(obj)
        "#{@prefix}#{Digest::SHA1.hexdigest(obj)}"
      end
    end
  end
end
