require 'minitest/spec'
begin
  require 'turn/autorun'
rescue LoadError
  require 'minitest/autorun'
end

require 'rotary'

# taken from: https://gist.github.com/jodosha/1560208

MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= {}
  end

  # http://stackoverflow.com/questions/12499259/why-doesnt-minitestspec-have-a-wont-raise-assertion
  def testForError # pass me a block and I'll tell you if it raised
    yield
    "ok"
  rescue
    $!
  end
end

module MiniTest::Spec::SharedExamples
  def shared_examples_for(desc, &block)
    MiniTest::Spec.shared_examples[desc] = block
  end

  def it_behaves_like(desc)
    self.instance_eval(&MiniTest::Spec.shared_examples[desc])
  end
end

Object.class_eval { include(MiniTest::Spec::SharedExamples) }
