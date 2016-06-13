require 'blended_config'

class Config < BlendedConfig
  group :colors do
    option(:blue)   { env  || file }
    option(:green)  { file || env }
    option(:red)    { env  || default_red_color }
    option(:purple) { file || "plum" }
    option(:yellow) { env  || file || 'marigold' }
  end

  def default_red_color
    "brick"
  end
end
