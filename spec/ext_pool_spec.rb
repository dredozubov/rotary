require 'spec_helper'
require 'ext_pool'

describe ExtPool do
  subject do
    ExtPool.new(storage: Redis.new)
  end
end
