require 'minitest/autorun'
require 'minitest/spec'

require '../lib/ext_pool'

describe ExtPool do

  let(:pool) { ExtPool.new(session: :string, storage: :memory) }

  it 'should get new session' do
  end

end
