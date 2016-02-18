# BlendedConfig

BlendedConfig gives you a simple dsl for indicating resolution order between the contents of config files, environment variables and default values. Say you've got this beautiful config file:
```toml
[colors]
blue   = "indigo"
green  = "lime"
red    = "maroon"
purple = "aubergine"
yellow = "mustard"
```

but you want only some environment variables to override these. Tell us your decisions like so:
```ruby
class ColorsConfig < BlendedConfig
  toml '.colors.toml'
  
  group(:colors) do
    option(:blue)   { env  || file }               # pretty standard
    option(:green)  { file || env }                # the reverse
    option(:red)    { env  || 'brick' }            # never read from file, but have a default
    option(:purple) { file || 'plum' }             # only read from the file, with a default
    option(:yellow) { env  || file || 'marigold' } # try everything
  end
end
```

You can now run your program with environment variables:

    $ COLORS_BLUE=cobalt COLORS_YELLOW=butterscotch spec/support/print-colors
    cobalt
    lime
    brick
    aubergine
    butterscotch

And it resolves your configuration correctly!


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blended_config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blended_config

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bundle install` to install its dependencies. Then, run `bundle exec spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yarmiganosca/blended_config. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

