module Tuiterator
  class Runner
    attr_reader :config

    def initialize
      @config = Tuiterator::Config.new
    end

    def run!
      EventMachine.run do
        Tuiterator::Jobs::BaseJob.run_all_jobs!(self)
      end
    end
  end
end
