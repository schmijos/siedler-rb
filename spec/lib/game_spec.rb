# frozen_string_literal: true

require 'game'

RSpec.describe Game do
  subject(:game) { described_class.new(board, player_names) }
  let(:board) { double }
  let(:player_names) { ['SaW'] }

  it { is_expected.not_to be_nil }

  describe '#commit' do
    subject(:commit) { game.commit(turn) }

    let(:turn) { double }

    it { is_anticipated.to change(game.turns, :count).by(1) }
  end
end
