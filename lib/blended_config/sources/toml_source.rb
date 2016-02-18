require 'blended_config/source'
require 'toml'

class BlendedConfig
  module Sources
    class TomlSource < Source
      def initialize(path)
        super(TOML.load_file(path))
      end
      alias toml raw_source
    end
  end
end
