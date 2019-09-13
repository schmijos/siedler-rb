# frozen_string_literal: true

require 'player'

RSpec.describe Player do
  subject(:player) { described_class.new('SaW') }

  it { is_expected.to have_attributes(name: 'SaW', resources: be_a(Hash), buildings: be_an(Array)) }
end
