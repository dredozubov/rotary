shared_examples_for :serializer do
  describe '.dump' do
    it 'return some kind of string' do
      subject.dump(obj).must_be_kind_of String
    end
  end

  describe '.load' do
    it 'returns the very same object' do
      stored = subject.dump(obj)
      subject.load(stored).must_equal obj
    end
  end
end
