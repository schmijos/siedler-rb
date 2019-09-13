# frozen_string_literal: true

class Hex
  attr_reader :type, :dice
  attr_accessor :bandit

  def initialize(type:, dice:)
    @type = type
    @dice = dice
    @bandit = false
  end

  def self.forest(dice)
    new(type: 'forest', dice: dice)
  end
end
