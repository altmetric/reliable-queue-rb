class ReliableQueue
  include Enumerable

  attr_reader :queue, :working_queue, :redis

  def initialize(queue, redis)
    @queue = queue
    @redis = redis
    @working_queue = "#{queue}.working_on"

    requeue_unfinished_work
  end

  def each
    return enum_for(:each) unless block_given?

    loop do
      reply = redis.brpoplpush(queue, working_queue, timeout: 30)
      next unless reply

      yield reply
      redis.lrem(working_queue, 0, reply)
    end
  end

  private

  def requeue_unfinished_work
    loop while redis.rpoplpush(working_queue, queue)
  end
end
