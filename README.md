# Reliable Queue [![Build Status](https://api.travis-ci.com/altmetric/reliable-queue-rb.svg?branch=main)](https://travis-ci.com/github/altmetric/reliable-queue-rb)

Ruby reliable queue implementation on top of Redis. It makes sure that message is not lost between popping it from Redis queue and compeleting the task.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'reliable-queue-rb', '~> 0.3.0'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install reliable-queue-rb
```

## Usage

Reliable Queue

```ruby
queue = ReliableQueue.new(redis_queue, redis_client)

queue.each do |message|
  # process message
end
```

ChunkedReliableQueue

```ruby
queue = ChunkedReliableQueue.new(working_on_queue_suffix, redis_queue, redis_client)

queue.each_slice(batch_size) do |messages|
  # process array of messages
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/altmetric/reliable-queue-rb>.

## License

Copyright © 2020-2021 Altmetric LLP

Distributed under the [MIT License](http://opensource.org/licenses/MIT).
