# frozen_string_literal: true

require 'lib/board'

RSpec.describe Board do
  subject(:instance) { described_class.new }

  describe '#field' do
    called_with(1, 1) { is_expected.to be_a(Hex) }
    called_with(55, 66) { is_expected.to be_nil }
    called_with(-1, -1) { is_expected.to be_nil }
  end

  describe '#neighbor_fields' do
    context 'when asked for spiky corners' do
      called_with(0, 6) { is_expected.to all(be_a(Hex)).and(have(2).items) }
      called_with(4, 0) { is_expected.to all(be_a(Hex)).and(have(2).items) }
    end

    context 'when asked for blunt corners' do
      called_with(0, 0) { is_expected.to all(be_a(Hex)).and(have(3).items) }
      called_with(4, 6) { is_expected.to all(be_a(Hex)).and(have(3).items) }
    end

    context 'when asked for edges' do
      called_with(0, 1) { is_expected.to all(be_a(Hex)).and(have(4).items) }
      called_with(0, 2) { is_expected.to all(be_a(Hex)).and(have(4).items) }
      called_with(0, 3) { is_expected.to all(be_a(Hex)).and(have(4).items) }
      called_with(1, 0) { is_expected.to all(be_a(Hex)).and(have(4).items) }
      called_with(2, 0) { is_expected.to all(be_a(Hex)).and(have(4).items) }
      called_with(3, 0) { is_expected.to all(be_a(Hex)).and(have(4).items) }
    end

    context 'when asked for embedded hexagons' do
      called_with(1, 1) { is_expected.to all(be_a(Hex)).and(have(6).items) }
      called_with(1, 5) { is_expected.to all(be_a(Hex)).and(have(6).items) }
      called_with(3, 1) { is_expected.to all(be_a(Hex)).and(have(6).items) }
      called_with(3, 5) { is_expected.to all(be_a(Hex)).and(have(6).items) }
      called_with(3, 3) { is_expected.to all(be_a(Hex)).and(have(6).items) }
    end
  end
end
