require "blended_config/version"
require 'blended_config/option_group'
require 'blended_config/option_resolver'
require 'blended_config/sources/environment'
require 'blended_config/sources/file'

class BlendedConfig
  def self.group(name, &options)
    option_group = OptionGroup.new(name, &options)
    option_groups << option_group

    define_method(name) { option_group }
  end

  def self.option(name, &resolution)
    option_resolver = OptionResolver.new(name, &resolution)
    option_resolvers << option_resolver

    define_method(name) { option_resolver }
  end

  def self.option_groups
    @option_groups ||= []
  end

  def self.option_resolvers
    @option_resolvers ||= []
  end

  def initialize(file: nil, env: ENV)
    bind_config_file(file) if file
    bind_environment(env)
  end

  private

  def bind_config_file(path)
    source = Sources::File.new(path)

    bind_source(:file, source)
  end

  def bind_environment(environment)
    source = Sources::Environment.new(environment)

    bind_source(:env, source)
  end

  private

  def bind_source(key, source)
    self.class.option_groups.each do |option_group|
      option_group.bind_source(key, source)
    end
  end    
end
