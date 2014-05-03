require 'spec_helper'
require 'ext_pool/serializer/string'
require 'serializer/shared_examples'

describe ExtPool::Serializer::String do

  let(:obj) { 'imma chargin my laser' }
  subject { ExtPool::Serializer::String } 

  it_behaves_like :serializer
end

