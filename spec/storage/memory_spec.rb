require 'spec_helper'
require 'rotary/storage/memory'
require 'storage/shared_examples'

describe Rotary::Storage::Memory do
  subject do
    Rotary::Storage::Memory.new
  end
  let(:obj) { 'super-session' }
  before(:each) { subject.push(obj) }
  after(:each) { subject.clear }

  it_behaves_like :storage
end
