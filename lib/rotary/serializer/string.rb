# Needed for testing. Acts as example.
module Rotary
  module Serializer
    module String
      def self.dump(value)
        value.to_s
      end

      def self.load(value)
        value
      end
    end
  end
end

