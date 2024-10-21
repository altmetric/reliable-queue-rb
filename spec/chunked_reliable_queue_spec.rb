require 'reliable_queue_rb/chunked_reliable_queue'
require 'redis'

RSpec.describe ChunkedReliableQueue do
  let(:redis) { Redis.new(host: ENV['REDIS_HOST'] || '127.0.0.1', port: ENV['REDIS_PORT'] || 6379) }

  after do
    redis.flushall
  end

  describe '.new' do
    it 'requeues any unfinished work for the given queue' do
      redis.lpush('foo.working_on.name1', '1')
      queue = described_class.new('name1', 'foo', redis)
      enum = queue.each_slice(1)

      expect(enum.next).to eq(['1'])
    end

    it 'does not block if there is no unfinished work' do
      queue = described_class.new('name1', 'foo', redis)

      expect(queue).to be_a(described_class)
    end
  end

  describe '#each_slice' do
    it 'returns work from the queue in order' do
      redis.lpush('foo', '1')
      redis.lpush('foo', '2')
      queue = described_class.new('name1', 'foo', redis)
      enum = queue.each_slice(2)

      expect(enum.next).to eq(['1', '2'])
    end

    it 'return chunks using a block' do
      redis.lpush('foo', '1')
      redis.lpush('foo', '2')
      redis.lpush('foo', '3')
      redis.lpush('foo', '4')
      queue = described_class.new('name1', 'foo', redis)

      result = []
      iteration = 0
      queue.each_slice(2) do |slice|
        result += slice
        iteration += 1
        break if iteration >= 2
      end

      expect(result).to eq(['1', '2', '3', '4'])
    end
  end
end
