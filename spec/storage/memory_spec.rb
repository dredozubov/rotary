require 'spec_helper'
require 'ext_pool/storage/memory'
require 'storage/shared_examples'

describe ExtPool::Storage::Memory do
  subject do 
    ExtPool::Storage::Memory.new
  end
  let(:obj) { 'super-session' }
  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  it_behaves_like :storage
end
