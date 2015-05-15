module Tuiterator
  class Config
    DEFAULTS = {
      keywords: ['lucas', 'tdc', 'floripa']
    }

    def initialize
      @config = DEFAULTS

      if block_given?
        yield @config
      end
    end

    def [](*args, &block)
      @config.send(:[], *args, &block)
    end

    def load_from_file(filename)
      @config = YAML.load_file(filename)
    end

    def method_missing(name, *args, &block)
      if @config[name]
        @config[name]
      elsif @config.respond_to?(name)
        @config.send(name, *args, &block)
      else
        super
      end
    end
  end
end
