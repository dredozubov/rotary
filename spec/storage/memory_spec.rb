require 'spec_helper'
require 'ext_pool/storage/memory'

describe ExtPool::Storage::Memory do

  subject do 
    ExtPool::Storage::Memory.new
  end
  let(:obj) { 'super-session' }
  before(:each) { subject.put(obj) }

  it 'puts one object in the pool' do
    subject.size.must_equal 1
  end

  it 'returns the same object' do
    subject.get.must_equal obj
  end

  it 'returns nil if storage pool is empty' do
    subject.get
    subject.get.must_be_nil
  end

end
