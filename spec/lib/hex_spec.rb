# frozen_string_literal: true

require 'hex'

RSpec.describe Hex do
  subject(:hex) { described_class.new(options) }

  let(:options) do
    { type: 'forest', dice: 4 }
  end

  it { is_expected.not_to be_nil }
  it { is_expected.to have_attributes(options) }

  it 'can assign the bandit' do
    expect { hex.bandit = true }.to change(hex, :bandit).from(false).to(true)
  end

  describe '#forest' do
    subject(:factory) { described_class.forest(11) }

    it { is_expected.to be_a(Hex) }
    it { is_expected.to have_attributes(type: 'forest', dice: 11) }
  end
end
