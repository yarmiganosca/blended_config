require 'blended_config/sources/toml_source'

class BlendedConfig
  module Sources
    class File
      def self.new(path)
        path      = Pathname.new(path)
        extension = path.extname[1..-1]

        send(extension, path)
      end

      def self.toml(path)
        TomlSource.new(path)
      end
    end
  end
end
