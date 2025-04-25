require_relative 'numbers'

class Digit
  attr_reader :grid
  attr_reader :number
  HEIGHT = 3
  WIDTH = 3

  def initialize(grid)
    raise ArgumentError, "Grid must be #{WIDTH}x#{HEIGHT}" unless grid.size == HEIGHT && grid.all? { |row| row.size == WIDTH }
    @grid = grid
    @number = parse_digit
  end

  def to_s
    @number.to_s
  end

  def value
    @number
  end

  def valid?
    @number.is_a? Integer
  end

  def parse_digit
    grid_x = grid.map { |str| str.gsub(/\s/, "x") }
    Numbers.grids.each_with_index do |number, number_index|
      return number_index if grid_x.join("\n") == number
    end
    "?"
  end
end