require 'ext_pool/serializer/string'
require 'ext_pool/serializer/marshal'

module ExtPool::Session
  def self.load_serializer(serializer)
    case serializer
    when Class
      serializer.new
    when [Symbol, String]
      self.class.const_get("ExtPool::serializer::#{serializer.capitalize}").new
    end
  end
end

