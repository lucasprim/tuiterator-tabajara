module Tuiterator
  class Broker
    def initialize
      @queue = Queue.new
    end

    def push(payload = "")
      puts "[Broker] Received payload #{payload}"

      @queue << payload
    end

    def pop
      if @queue.size > 0
        @queue.pop
      end
    end
  end
end
