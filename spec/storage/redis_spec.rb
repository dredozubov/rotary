require 'spec_helper'
require 'rotary/storage/redis'
require 'rotary/serializer/marshal'
require 'storage/shared_examples'

require 'redis'

describe Rotary::Storage::Redis do
  let(:obj) { OpenStruct.new(a: 1, b: 2) }
  let(:connection) { Rotary::Storage::Redis.default_connection }
  let(:serializer) { Rotary::Serializer::Marshal }

  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  subject do
    Rotary::Storage::Redis.new(
      connection: connection,
      prefix: 'test',
      ttl: nil,
      serializer: serializer
    )
  end

  it_behaves_like :storage

  # ttl functionality not tested properly
  describe 'ttl' do
    before do
      @rotary_1sec = Rotary::Storage::Redis.new(
        connection: connection,
        prefix: 'ttl_test',
        ttl: 1,
        serializer: serializer
      )
      @rotary_60sec = Rotary::Storage::Redis.new(
        connection: connection,
        prefix: 'ttl_test',
        ttl: 60,
        serializer: serializer
      )

      # clear
      @rotary_1sec.clear
    end

    after { @rotary_1sec.clear }

    describe '#clean_older_than' do
      it 'removes sessions which satisfy the condition' do
        10.times { |i| @rotary_60sec.push("session#{i}") }

        sleep(2)

        10.upto(19) { |i| @rotary_60sec.push("session#{i}") }

        @rotary_60sec.clean_older_than(1)
        @rotary_60sec.size.must_equal 10
      end

      it 'removes expired sessions' do
        10.times { |i| @rotary_1sec.push("session#{i}") }

        sleep(2)

        @rotary_1sec.clean_older_than(7) # this is greater than ttl
        @rotary_1sec.size.must_equal 0
      end

      it 'leaves young sessions untouched' do
        10.times { |i| @rotary_60sec.push("session#{i}") }

        @rotary_1sec.clean_older_than(7)
        @rotary_1sec.size.must_equal 10
      end
    end
  end
end

