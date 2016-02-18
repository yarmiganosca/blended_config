require 'blended_config/sources/environment'

class BlendedConfig
  class OptionResolver
    def initialize(name, &resolution)
      @name       = name
      @resolution = resolution
      @sources    = {}
    end

    def value
      instance_exec(&@resolution)
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
