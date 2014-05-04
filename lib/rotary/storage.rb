require 'rotary/storage/memory'
require 'rotary/storage/redis'

module Rotary
  module Storage

    class Error < Exception
    end

    def self.load_storage(storage)
      const_get("Rotary::Storage::#{storage.capitalize}")
    rescue NameError
      raise Rotary::Storage::Error,
        "Wrong storage #{storage} of class #{storage.class}"
    end
  end
end
