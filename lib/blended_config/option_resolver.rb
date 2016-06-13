require 'blended_config/sources/environment'

class BlendedConfig
  class OptionResolver
    attr_accessor :fallback

    def initialize(name, &resolution)
      @name       = name
      @resolution = resolution
      @sources    = {}
    end

    def value
      instance_exec(&resolution)
    end

    def file
      sources[:file][name]
    end

    def env
      sources[:env][name]
    end

    def bind_source(key, source)
      sources[key] = source
    end

    def method_missing(sym, *args, &blk)
      if fallback.respond_to?(sym)
        fallback.send(sym, *args, &blk)
      else
        super
      end
    end

    def respond_to_missing?(sym, check_private_methods = false)
      fallback.respond_to?(sym, check_private_methods)
    end

    private

    attr_reader :name, :resolution, :sources
  end
end
