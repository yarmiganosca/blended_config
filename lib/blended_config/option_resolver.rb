require 'blended_config/sources/environment'

class BlendedConfig
  class OptionResolver
    def initialize(name, &lookup_preference)
      @name              = name
      @lookup_preference = lookup_preference
      @sources           = {}
    end

    def value
      instance_exec(&@lookup_preference)
    end

    def file
      @sources[:file][@name]
    end

    def env
      @sources[:env][@name]
    end

    def bind_source(key, source)
      @sources[key] = source
    end
  end
end
