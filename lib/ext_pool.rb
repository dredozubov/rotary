module ExtPool
  class Pool
    def initialize(storage: :memory, session: , limit: 100)
      @limit = limit
      load_storage(storage)
    end

    def load_storage(storage)
      @storage = case storage
        when Class
          storage.new
        when [Symbol, String]
          self.class.const_get("ExtPool::Storage::#{storage.capitalize}").new
      end
    end

    def get
      @storage.get
    end

    def put
      @storage.put
    end
  end
end

require 'ext_pool/version'