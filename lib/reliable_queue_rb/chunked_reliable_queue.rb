class ChunkedReliableQueue
  DEFAULT_SIZE = 100

  attr_reader :name, :queue, :size, :working_queue, :redis

  def initialize(name, queue, redis)
    @name = name
    @queue = queue
    @redis = redis
    @working_queue = "#{queue}.working_on.#{name}"

    requeue_unfinished_work
  end

  def each_slice(size = DEFAULT_SIZE)
    return enum_for(:each_slice, size) unless block_given?

    loop do
      blocking_reply = redis.brpoplpush(queue, working_queue, timeout: 30)
      next unless blocking_reply

      replies = [blocking_reply]
      replies += redis.multi { |multi|
        (size - 1).times do
          multi.rpoplpush(queue, working_queue)
        end
      }.compact

      yield replies
      redis.multi do |multi|
        replies.each do |reply|
          multi.lrem(working_queue, 0, reply)
        end
      end
    end
  end

  private

  def requeue_unfinished_work
    loop while redis.rpoplpush(working_queue, queue)
  end
end
