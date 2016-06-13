require "blended_config/version"
require 'blended_config/option_group'
require 'blended_config/option_resolver'
require 'blended_config/sources/environment'
require 'blended_config/sources/file'

class BlendedConfig
  def self.group(name, &options)
    option_group = OptionGroup.new(name, &options)
    option_groups << option_group

    define_method(name) do
      option_group.fallback = self
      option_group
    end
  end

  def self.option(name, &resolution)
    option_resolver = OptionResolver.new(name, &resolution)
    option_resolvers << option_resolver

    define_method(name) do
      option_resolver.fallback = self
    end
  end

  def self.option_groups
    @option_groups ||= []
  end

  def self.option_resolvers
    @option_resolvers ||= []
  end

  def initialize(env: ENV, **options)
    bind_config_file(options)
    bind_environment(env)
  end

  private

  def bind_config_file(options)
    source = Sources::File.new(options)

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
