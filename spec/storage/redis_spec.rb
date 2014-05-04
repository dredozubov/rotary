require 'spec_helper'
require 'ext_pool/storage/redis'
require 'ext_pool/serializer/marshal'
require 'storage/shared_examples'

require 'redis'

describe ExtPool::Storage::Redis do
  let(:connection) { Redis.new }
  let(:obj) { OpenStruct.new(a: 1, b: 2) }
  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  subject do
    ExtPool::Storage::Redis.new(
      connection: connection,
      prefix: 'test',
      serializer: ExtPool::Serializer::Marshal
    )
  end

  it_behaves_like :storage

  # ttl functionality not tested properly
end

