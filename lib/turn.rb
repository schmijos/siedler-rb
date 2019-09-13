class Turn
  def initialize(player_name, command, arguments = {})
    @player = player_name
    @command = command
    @arguments = arguments
  end

  def valid?(board)
    case command
    when :noop
      true
    when :setup
      valid_setup?(board, **arguments)
    when :build_town
      valid_build_town?(board, **arguments)
    when :build_city
      valid_build_city?(board, **arguments)
    when :build_street
      valid_build_city?(board, **arguments)
    else
      raise
    end
  end

  def valid_setup?(board, town_vertex:, street_edge:)
    !board.street(street_edge) && !board.building(town_vertex)
  end

  def valid_build_town?(board, vertex:)
    !board.building(vertex) &&
      [vertex[0..1], vertex[1..2], [vertex[0], vertex[2]]].any? { |edge| building.street(edge) == @player } &&
      board.neighbor_vertex_coordinates(vertex).none? { |v| board.building(v) }
  end
end
