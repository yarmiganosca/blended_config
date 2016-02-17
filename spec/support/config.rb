require 'blended_config'

class Config < BlendedConfig
  group :colors do
    option(:blue)   { file || env }
    option(:green)  { env  || file }
    option(:red)    { file || "maroon" }
    option(:purple) { env  || "aubergine" }
    option(:yellow) { file || env || 'marigold' }
  end
end
