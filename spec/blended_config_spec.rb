require 'spec_helper'
require_relative 'support/config.rb'

RSpec.describe BlendedConfig do
  describe 'toml configs' do
    let(:config_file) { Pathname.new(__FILE__).dirname/'support'/'config.toml' }
    let(:environment) do
      OpenStruct.new(
        COLORS_BLUE:   "indigo",
        COLORS_RED:    "crimson",
        COLORS_PURPLE: "violet"
      )
    end
    subject(:toml) { Config.new(toml: config_file, env: environment) }

    describe '#colors' do
      it 'is memoized' do
        expect(toml.colors.object_id).to eq toml.colors.object_id
      end

      it 'has the correct blue' do
        expect(toml.colors.blue).to eq "indigo"
      end

      it 'has the correct green' do
        expect(toml.colors.green).to eq "lime"
      end

      it 'has the correct red' do
        expect(toml.colors.red).to eq "crimson"
      end

      it 'has the correct purple' do
        expect(toml.colors.purple).to eq "aubergine"
      end

      it 'has the correct yellow' do
        expect(toml.colors.yellow).to eq 'mustard'
      end
    end
  end
end
