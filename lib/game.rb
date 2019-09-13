class Game
  attr_reader :turns

  TOWN_COST = { brick: 1, lumber: 1, wool: 1, grain: 1, ore: 0 }.freeze
  CITY_COST = { brick: 0, lumber: 0, wool: 0, grain: 2, ore: 3 }.freeze
  STREET_COST = { brick: 1, lumber: 1, wool: 0, grain: 0, ore: 0 }.freeze

  def initialize(board, player_names)
    @board = board
    @players = player_names.map { |name| Player.new(name) }
    @turns = []
  end

  def commit(turn)
    if turn.valid?(board)
      apply(turn)
      @turns << turn
      true
    else
      false
    end
  end

  def tick
    # assign resources
  end

  def commit!(turn)
    raise 'invalid turn' unless commit(turn)
  end

  def valid?(turn)
    can_afford? && board_allows?(turn)
  end
end
