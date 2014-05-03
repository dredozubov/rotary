require 'spec_helper'
require 'ext_pool/storage/memory'

describe ExtPool::Storage::Memory do

  subject do 
    ExtPool::Storage::Memory.new
  end
  let(:obj) { 'super-session' }
  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  it 'puts one object in the pool' do
    subject.size.must_equal 1
  end

  it 'returns the same object' do
    subject.pop.must_equal obj
  end

  it 'returns nil if storage pool is empty' do
    subject.pop
    subject.pop.must_be_nil
  end

  it 'returns self on push' do
    subject.push(obj).must_be_instance_of subject.class
  end

  it 'works with more than one obj' do
    subject.push(obj)
    subject.size.must_equal 2
  end

  it '#clear clears the storage' do
    subject.clear
    subject.size.must_equal 0
  end

end
