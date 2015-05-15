# encoding: utf-8
module Tuiterator
  module Jobs
    class GloboJob < BaseJob
      attr_reader :headline, :new_headline, :headline_xpath, :globo_url

      def initialize
        @headline_xpath = \
          '//*[@id="bloco-principal"]/div[1]/div[1]/div[1]/div/a/div/h2'
        @globo_url = 'http://www.globo.com'
      end

      def run
        EM.add_periodic_timer(2, &main_loop)
      end

      private

      def main_loop
        -> do
          fetch_headline

          # This happens not for the request above but for the
          # previous one. That's because the request above is asynchronous
          # and will not have returned so far.
          if new_headline != headline
            @headline = new_headline
            BaseJob.broker.push("Globo.com: #{new_headline}")
          end
        end
      end

      def fetch_headline
        http = EventMachine::HttpRequest.new(globo_url).get

        http.errback { puts "[GloboJob] Failed to fetch headline!" }
        http.callback do
          document = Nokogiri::XML http.response
          @new_headline = document.search(headline_xpath).text
        end
      end
    end
  end
end
