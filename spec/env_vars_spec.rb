require 'spec_helper'
require_relative 'support/config.rb'

RSpec.describe 'colors print' do
  let(:environment) do
    {
      "COLORS_BLUE"   => "indigo",
      "COLORS_GREEN"  => "lime",
      "COLORS_YELLOW" => "mustard"
    }
  end

  let(:expected_output) do
    <<-OUT
indigo
lime
brick
aubergine
mustard
    OUT
  end

  it 'prints colors' do
    expect {
      system(environment, "spec/support/print-colors")
    }.to output(expected_output).to_stdout_from_any_process
  end
end
