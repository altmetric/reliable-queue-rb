require 'reliable_queue_rb/reliable_queue'
require 'redis'

RSpec.describe ReliableQueue do
  let(:redis) { Redis.new }

  after do
    redis.del('foo')
  end

  describe '.new' do
    it 'requeues any unfinished work for the given queue' do
      redis.rpush('foo.working_on', '1')
      queue = described_class.new('foo', redis)

      expect(queue.first).to eq('1')
    end

    it 'does not block if there is no unfinished work' do
      queue = described_class.new('foo', redis)

      expect(queue).to be_a(described_class)
    end
  end

  describe '#each' do
    it 'returns work from the queue in order' do
      redis.lpush('foo', '1')
      redis.lpush('foo', '2')
      queue = described_class.new('foo', redis)

      expect(queue.take(2)).to eq(['1', '2'])
    end
  end
end
