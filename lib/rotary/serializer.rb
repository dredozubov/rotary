require 'rotary/serializer/string'
require 'rotary/serializer/marshal'

module Rotary::Serializer

  class Error < Exception
  end

  class << self
    def load_serializer(serializer)
      case serializer
      when Symbol
        load_const(serializer)
      else
        unless valid?(serializer)
          raise Rotary::Serializer::Error,
            "#{serializer}:#{serializer.class} doesn't respond to either '.load' or '.dump'"
        end
        serializer
      end
    end

    def load_const(serializer)
      const_get("Rotary::Serializer::#{serializer.capitalize}")
    rescue NameError
      raise_wrong_serializer!(serializer)
    end

    def valid?(serializer)
      serializer.respond_to?(:dump) && serializer.respond_to?(:load)
    end

    def raise_wrong_serializer!(serializer)
      raise Rotary::Serializer::Error, "Wrong serializer #{serializer} of class #{serializer.class}"
    end
  end
end

