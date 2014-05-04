require 'spec_helper'
require 'rotary/storage/redis'
require 'rotary/serializer/marshal'
require 'storage/shared_examples'

require 'redis'

describe Rotary::Storage::Redis do

  let(:obj) { OpenStruct.new(a: 1, b: 2) }
  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  subject do
    Rotary::Storage::Redis.new(
      connection: Rotary::Storage::Redis.default_connection,
      prefix: 'test',
      ttl: nil,
      serializer: Rotary::Serializer::Marshal
    )
  end

  it_behaves_like :storage

  # ttl functionality not tested properly
end

