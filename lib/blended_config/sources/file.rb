require 'blended_config/sources/toml_source'

class BlendedConfig
  module Sources
    class File
      def self.new(options)
        path      = Pathname.new(options[:toml])
        extension = :toml

        send(extension, path)
      end

      def self.toml(path)
        TomlSource.new(path)
      end
    end
  end
end
