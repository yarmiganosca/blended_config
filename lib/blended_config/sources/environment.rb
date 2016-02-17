require 'blended_config/source'

class BlendedConfig
  module Sources
    class Environment < Source
      alias env raw_source

      def [](key)
        var = (prefixes + [key]).join('_').upcase

        env[var]
      end
    end
  end
end
