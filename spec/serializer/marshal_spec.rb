require 'spec_helper'
require 'rotary/serializer/string'
require 'serializer/shared_examples'

describe Rotary::Serializer::String do

  let(:obj) { 'imma chargin my laser' }
  subject { Rotary::Serializer::String } 

  it_behaves_like :serializer
end

