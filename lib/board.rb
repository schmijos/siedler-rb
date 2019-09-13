# frozen_string_literal: true

require 'lib/hex'

# Hex grid 3 x 5, [0..2, 0..4]
#   ⬡⬡⬡⬡⬡
#  ⬡⬡⬡⬡⬡
# ⬡⬡⬡⬡⬡

class Board
  NEIGHBOR_HEX_VECTORS = [
       [-1, -1], [-1, -0],
    [-0, -1],       [+0, +1],
       [+1, +0], [+1, +1]
  ].freeze

  def neighbor_hex_coordinates(hex)
    NEIGHBOR_HEX_VECTORS.map { |v| [hex[0] + v[0], hex[1] + v[1]] }
  end

  def neighbor_vertex_coordinates(vertex)
    [
      [vertex[0], vertex[1], (neighbor_hex_coordinates(vertex[0]) & neighbor_hex_coordinates(vertex[1])) - vertex[2]],
      [vertex[1], vertex[2], (neighbor_hex_coordinates(vertex[1]) & neighbor_hex_coordinates(vertex[2])) - vertex[0]],
      [vertex[2], vertex[0], (neighbor_hex_coordinates(vertex[2]) & neighbor_hex_coordinates(vertex[0])) - vertex[1]],
    ]
  end

  class Edges
    def initialize
      @edges = {}
    end

    def [](hex_a, hex_b)
      @edges[[hex_a, hex_b].sort]
    end

    def []=(hex_a, hex_b, value)
      raise "#{hex_a} and #{hex_b} are not adjacent" unless adjacent?(hex_a, hex_b)

      @edges[[hex_a, hex_b].sort] = value
    end

    def adjacent?(hex_a, hex_b)
      neighbor_hex_coordinates(hex_a).include?(hex_b)
    end
  end

  class Vertices
    def initialize
      @vertices = {}
    end

    def [](hex_a, hex_b, hex_c)
      @vertices[[hex_a, hex_b, hex_c].sort]
    end

    def []=(hex_a, hex_b, hex_c, value)
      raise "#{hex_a}, #{hex_b} and #{hex_c} are not adjacent" unless adjacent?(hex_a, hex_b, hex_c)

      @vertices[[hex_a, hex_b, hex_c].sort] = value
    end

    def adjacent?(hex_a, hex_b, hex_c)
      neighbor_hex_coordinates(hex_a).include?(hex_b) &&
        neighbor_hex_coordinates(hex_b).include?(hex_c) &&
        neighbor_hex_coordinates(hex_c).include?(hex_a)
    end
  end

  def initialize
    @hex_grid = [
      [1, 1, 1, 1, 1, 1, 1],
      [2, 2, 2, 2, 2, 2, 2],
      [3, 3, 3, 3, 3, 3, 3],
      [4, 4, 4, 4, 4, 4, 4],
      [5, 5, 5, 5, 5, 5, 5]
    ].map do |row|
      row.map { |dice| Hex.forest(dice) }
    end

    @edges = Edges.new
    @vertices = Vertices.new
  end

  def field(row, col)
    return nil if row.negative? || col.negative?

    @hex_grid.fetch(row, {}).fetch(col, nil)
  end

  def neighbor_fields(row, col)
    neighbor_hex_coordinates([row, col]).map { |v| field(v[0], v[1]) }
  end

  def street(hex_a, hex_b)
    @edges[hex_a, hex_b]
  end

  def building(hex_a, hex_b, hex_c)
    @vertices[hex_a, hex_b, hex_c]
  end
end
