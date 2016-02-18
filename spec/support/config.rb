require 'blended_config'

class Config < BlendedConfig
  group :colors do
    option(:blue)   { env  || file }
    option(:green)  { file || env }
    option(:red)    { env  || "brick" }
    option(:purple) { file || "plum" }
    option(:yellow) { env  || file || 'marigold' }
  end
end
