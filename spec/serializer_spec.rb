require 'spec_helper'
require 'rotary/serializer'

describe Rotary::Serializer do
  describe '.load_serializer' do

    subject { Rotary::Serializer }

    let(:empty_module) { Module.new }
    let(:empty_class) { Class.new }

    it 'loads valid module' do
      module TestModule
        def self.dump; 'dump'; end
        def self.load; 'dump'; end
      end
      subject.load_serializer(TestModule).must_equal TestModule
    end

    it 'fails with wrong module' do
      proc { subject.load_serializer empty_module }.must_raise Rotary::Serializer::Error
    end

    it 'loads valid class' do
      class TestClass
        def self.dump; 'dump'; end
        def self.load; 'dump'; end
      end
      subject.load_serializer(TestClass).must_equal TestClass
    end

    it 'fails with a wrong class' do
      proc { subject.load_serializer empty_class }.must_raise Rotary::Serializer::Error
    end

    it 'loads with a symbol' do
      subject.load_serializer(:marshal).must_equal Rotary::Serializer::Marshal
    end

    it 'loads with an uppercase symbol' do
      subject.load_serializer(:Marshal).must_equal Rotary::Serializer::Marshal
    end

    it 'fails with a wrong symbol' do
      proc { subject.load_serializer :wrong }.must_raise Rotary::Serializer::Error
    end

    #it 'loads with a string' do
      #subject.load_serializer('marshal').must_equal Rotary::Serializer::Marshal
    #end

    #it 'loads with an uppercase string' do
      #subject.load_serializer('Marshal').must_equal Rotary::Serializer::Marshal
    #end

    #it 'fails with a wrong string' do
      #proc { subject.load_serializer 'Oops' }.must_raise Rotary::Serializer::Error
    #end

  end
end
