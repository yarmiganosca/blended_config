class BlendedConfig
  class Source < Struct.new(:raw_source)
    def prefixes
      @prefixes ||= []
    end
    
    def prefix_with(prefix)
      prefixes << prefix
    end

    def [](key)
      key_fragments = prefixes + [key]

      key_fragments.reduce(raw_source) do |value, key_fragment|
        value[key_fragment.to_s]
      end
    end
  end
end
