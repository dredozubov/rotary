require 'spec_helper'
require 'rotary/storage/redis'
require 'rotary/serializer/marshal'
require 'storage/shared_examples'

require 'redis'

describe Rotary::Storage::Redis do
  let(:connection) { Redis.new }
  let(:obj) { OpenStruct.new(a: 1, b: 2) }
  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  subject do
    Rotary::Storage::Redis.new(
      connection: connection,
      prefix: 'test',
      serializer: Rotary::Serializer::Marshal
    )
  end

  it_behaves_like :storage

  # ttl functionality not tested properly
end

