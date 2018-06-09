require 'byebug'

class Board
  SHIPS = {
    Carrier: 5,
    Battleship: 4,
    Submarine: 3,
    Cruiser: 3,
    Destroyer: 2
  }

  attr_reader :grid

  def initialize(grid = Board.default_grid)
    @grid = grid
  end

  def self.default_grid
    @grid = Array.new(10) { Array.new(10) }
  end

  def populate_grid
    #debugger
    SHIPS.each do |ship, ship_size|
      add_ship(ship, ship_size)
    end
  end

  def add_ship(ship, ship_size)
    directions = [:v, :h]
    rand_dir = directions.sample
    add_vertical_ship(ship, ship_size) if rand_dir == :v
    add_horizontal_ship(ship, ship_size) if rand_dir == :h
  end

  def add_vertical_ship(ship, ship_size)
    ship_added = false

    while !ship_added
      rand_row = rand(grid.length)
      rand_col = rand(grid.length)
      pos = [rand_row, rand_col]

      if rand_row + ship_size > 9
        range = (rand_row - ship_size...rand_row)
        if range.all? { |row| grid[row][rand_col] == nil}
          range.each do |row|
            pos = [row, rand_col]
            self[pos] = :s
          end

          ship_added = true
        end
      else
        range = (rand_row...rand_row + ship_size)
        if range.all? { |row| grid[row][rand_col] == nil }
          range.each do |row|
            pos = [row, rand_col]
            self[pos] = :s
          end

          ship_added = true
        end
      end
    end
  end

  def add_horizontal_ship(ship, ship_size)
    ship_added = false

    while !ship_added
      rand_row = rand(grid.length)
      rand_col = rand(grid.length)
      pos = [rand_row, rand_col]

      if rand_col + ship_size > 9
        range = (rand_col - ship_size...rand_col)
        if range.all? { |col| grid[rand_row][col] == nil }
          range.each do |col|
            pos = [rand_row, col]
            self[pos] = :s
          end

          ship_added = true
        end
      else
        range = (rand_col...rand_col + ship_size)
        if range.all? { |col| grid[rand_row][col] == nil }
          range.each do |col|
            pos = [rand_row, col]
            self[pos] = :s
          end

          ship_added = true
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    grid[row][col] = mark
  end

  def empty?(pos = nil)
    if pos
      self[pos].nil?
    else
      count == 0
    end
  end

  def full?
    @grid.all? do |row|
      row.none? { |space| space == nil }
    end
  end

  def won?
    @grid.all? do |row|
      row.none? { |space| space == :s }
    end
  end

  def place_random_ship
    if full?
      raise error
    else
      ship_added = false
      while !ship_added
        pos = [rand(grid.length), rand(grid.length)]
        if empty?(pos)
          ship_added = true
          self[pos] = :s
        end
      end
    end
  end

  def count
    @grid.reduce(0) do |acc, el|
      acc + el.count(:s)
    end
  end

  def display
    puts "    0   1   2   3   4   5   6   7   8   9   "
    print "  -----------------------------------------\n"
    cols = (0..9).to_a
    grid.each_with_index do |row, i|

      print "#{cols[i]} |"
      row.each do |space|
        print "   |" if space == nil
        print " M |" if space == :x
        print " H |" if space == :s
      end
      print "\n  -----------------------------------------\n"
    end
  end
end
