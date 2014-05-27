module Autofigurator
  class Config
    attr_reader :filename
    def initialize(example_file, stage = nil)
      @filename = File.basename(example_file, '.example')
      @stage = stage
      @config = YAML.load_file(example_file)
    end

    def config
      @config_context ||= @config.has_key?(@stage) ? @config[@stage] : @config
    end
  end
end

