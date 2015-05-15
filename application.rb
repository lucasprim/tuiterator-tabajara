$:.unshift File.join(File.dirname(__FILE__), "lib")

require 'bundler/setup'
require 'tuiterator'

runner = Tuiterator::Runner.new

runner.config.load_from_file("config.yml")

runner.run!
