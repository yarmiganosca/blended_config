require 'blended_config/option_resolver'

class BlendedConfig
  class OptionGroup
    attr_accessor :fallback

    def initialize(name, &options)
      @name      = name
      @resolvers = []

      instance_exec(&options)
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

    def option(option_name, &resolution)
      resolver = OptionResolver.new(option_name, &resolution)

      resolvers << resolver

      self.class.class_exec do
        define_method(option_name) do
          resolver.fallback = self
          resolver.value
        end
      end
    end

    def bind_source(key, source)
      source.prefix_with(name)

      resolvers.each do |resolver|
        resolver.bind_source(key, source)
      end
    end

    private

    attr_reader :name, :resolvers
  end
end
