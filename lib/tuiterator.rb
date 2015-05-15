$:.unshift File.join(File.dirname(__FILE__), "tuiterator")

require 'eventmachine'
require 'em-websocket'
require 'em-http-request'
require 'nokogiri'
require 'yaml'
require 'pry' unless ENV['ENV'] =~ /^production$/i
require 'tweetstream'

require 'broker'
require 'config'

require 'jobs/base_job'
require 'jobs/stream_job'
require 'jobs/globo_job'
require 'jobs/socket_job'

require 'runner'

module Tuiterator
  VERSION = "0.0.1"
end
