require 'spec_helper'
require 'rotary/storage'

describe Rotary::Storage do
  describe '.load_storage' do

    subject { Rotary::Storage }

    it 'loads valid symbol' do
      subject.load_storage(:redis)
    end

    it 'fails with wrong symbol' do
      proc { subject.load_storage(:totally_wrong) }.must_raise Rotary::Storage::Error
    end

    it 'loads with a connection' do
      subject.load_storage(:redis, connection: OpenStruct.new(fake: :connection))
    end
  end
end

