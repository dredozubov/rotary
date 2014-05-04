require 'spec_helper'
require 'rotary'

describe Rotary do
  subject do
    Rotary.new(
      connection: Redis.new,
    ) { OpenStruct.new(fake: :object) }
  end
end
