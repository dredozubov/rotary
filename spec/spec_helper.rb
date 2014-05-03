require 'turn/autorun'
require 'minitest/spec'

require 'ext_pool'

MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= {}
  end
end
 
def shared_examples_for(desc, &block)
  MiniTest::Spec.shared_examples[desc] = block
end
 
def it_behaves_like(desc, &block)
  describe desc do
    instance_eval &MiniTest::Spec.shared_examples[desc]
    instance_eval &block if block_given?
  end
end
