# encoding: utf-8
module Tuiterator
  module Jobs
    class StreamJob < BaseJob
      def run
        keywords = BaseJob.runner.config.fetch('keywords') {
          fail 'You need to provide keywords when running the StreamJob!' }
        tw_config = BaseJob.runner.config.fetch('twitter') {
          fail 'You need to provide twitter conf when running the StreamJob!' }

        TweetStream.configure do |config|
          config.consumer_key       = tw_config.fetch('consumer_key')
          config.consumer_secret    = tw_config.fetch('consumer_secret')
          config.oauth_token        = tw_config.fetch('oauth_token')
          config.oauth_token_secret = tw_config.fetch('oauth_token_secret')
          config.auth_method        = :oauth
        end

        # Use 'track' to track a list of single-word keywords
        TweetStream::Client.new.track(*keywords) do |status|
          user_picture = status.user.profile_image_uri(:original).to_s
          BaseJob.broker.push(
            text: ("" + status.text).force_encoding("utf-8"),
            image: user_picture
          )
        end
      end
    end
  end
end
