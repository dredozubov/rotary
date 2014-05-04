require 'spec_helper'
require 'rotary'

describe Rotary do
  subject do
    Rotary.new(storage: Redis.new)
  end
end
