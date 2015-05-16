module Tuiterator
  module Jobs
    class SocketJob < BaseJob
      def run
        puts "Running socket job!"

        EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|

          EM.add_periodic_timer(1) do
            while message = BaseJob.broker.pop
              ws.send message.to_json
            end
          end

          ws.onopen { |handshake|
            puts "WebSocket connection open"

            # Access properties on the EM::WebSocket::Handshake object, e.g.
            # path, query_string, origin, headers

            # Publish message to the client
            ws.send "Hello Client, you connected to #{handshake.path}"
          }

          ws.onclose { puts "Connection closed" }

          ws.onmessage { |msg|
            puts "Recieved message: #{msg}"
            ws.send "Pong: #{msg}"
          }
        end
      end
    end
  end
end
