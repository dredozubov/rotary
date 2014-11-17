require 'spec_helper'
require 'rotary'

describe Rotary do
  let(:obj) { OpenStruct.new(fake: :object) }
  subject do
    Rotary.pool limit: 10, create: -> { obj }
  end
  after(:each) { subject.clear }

  describe '.pool' do
    it 'returns pool manager' do
      subject.must_be_kind_of Rotary::Pool
    end
  end

  describe Rotary::Pool do
    describe 'on empty pool' do
      describe '#get' do
        it 'returns object from pool' do
          subject.get.must_equal obj
        end
      end

      describe '#with' do
        it 'does stuff with one object from pool' do
          subject.with do |obj|
            obj.fake = :new_object
            obj
          end
          subject.get.fake.must_equal :new_object
        end

        it 'return object in a pool' do
          subject.with { |obj| obj }
          subject.size.must_equal 1
        end
      end

      describe '#set' do
        it 'puts objects in a pool' do
          2.times { subject.set(obj) }
          subject.size.must_equal 2
        end
      end
    end

    describe 'with non empty pool' do
      before(:each) { subject.set(obj) }

      describe '#get' do
        it 'returns object from pool' do
          subject.get.must_equal obj
        end
      end
    end

    describe 'above pool limit' do
      it 'raises exception by default' do
        proc { 11.times { subject.set(obj) } }.must_raise Rotary::OverflowError
      end
    end

    describe '#clean_older_than' do
      it 'passes without raising error for redis backend' do
        pool = Rotary.pool(
          storage: :redis,
          prefix: "whatever",
          limit: 10,
          ttl: 10
        )
        pool.clean_older_than(5)
      end

      it 'fails with memory backend' do
        pool = Rotary.pool(
          storage: :memory,
          prefix: "whatever",
          limit: 10,
          ttl: 10
        )
        testForError do
          pool.clean_older_than(5)
        end
      end

      it 'executes block if given' do
        mock = Mocker.new # expectation inside

        subject.set(mock)
        sleep(2)
        subject.clean_older_than(1) { |s| s.tester }
      end
    end
  end

  it 'executes custom on_overflow callback' do
    pool = Rotary.pool create: -> { obj }, limit: 2, on_overflow: ->(obj) { :nope }
    2.times { pool.set(obj) }
    pool.set(obj).must_equal :nope
  end
end
