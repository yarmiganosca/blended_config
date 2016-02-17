require 'blended_config/source'
require 'toml'

class BlendedConfig
  module Sources
    class TomlSource < Source
      def initialize(path)
        super(TOML.load_file(path))
      end
      alias toml raw_source

      def [](key)
        (prefixes + [key]).reduce(toml) do |value, key_fragment|
          value[key_fragment.to_s]
        end
      end
    end
  end
end
