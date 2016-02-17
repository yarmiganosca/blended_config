require 'blended_config/option_resolver'

class BlendedConfig
  class OptionGroup
    def initialize(name, &options)
      @name      = name
      @resolvers = []

      instance_exec(&options)
    end

    def option(option_name, &resolution)
      resolver = OptionResolver.new(option_name, &resolution)

      @resolvers << resolver

      self.class.class_exec do
        define_method(option_name) { resolver.value }
      end
    end

    def bind_source(key, source)
      source.prefix_with(@name)

      @resolvers.each do |resolver|
        resolver.bind_source(key, source)
      end
    end    
  end
end
