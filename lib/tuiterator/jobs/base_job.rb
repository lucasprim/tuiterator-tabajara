# encoding: utf-8
module Tuiterator
  module Jobs
    class BaseJob
      class << self
        attr_reader :jobs, :runner
      end

      def self.inherited(klass)
        @jobs ||= []
        @jobs.push klass
      end

      def self.run_all_jobs!(runner)
        fail NotImplementedError if !@jobs || @jobs.count == 0

        @runner = runner

        @jobs.each do |job_class|
          job = job_class.new
          job.run
        end
      end

      def self.broker
        @broker ||= Tuiterator::Broker.new
      end

      def run
        fail NotImplementedError, "You must override this method son!"
      end
    end
  end
end
