# taken from: https://gist.github.com/jodosha/1560208
shared_examples_for :storage do
  describe '#push' do
    it 'puts one object in the pool' do
      subject.size.must_equal 1
    end

    it 'returns self on push' do
      subject.push(obj).must_be_instance_of subject.class
    end

    it 'works with more than one obj' do
      subject.push(obj)
      subject.size.must_equal 2
    end
  end

  describe '#pop' do
    it 'returns the same object' do
      subject.pop.must_equal obj
    end
  end

  describe '#size' do
    it 'returns nil if storage pool is empty' do
      subject.pop
      subject.pop.must_be_nil
    end
  end

  describe '#clear' do
    it 'clears the storage' do
      subject.clear
      subject.size.must_equal 0
    end
  end
end
