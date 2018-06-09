class HumanPlayer
  attr_reader :name, :board, :tracking_board

  def initialize(name = "Ronil")
    @name = name
    @board = Board.new
    @tracking_board = Board.new
  end

  def get_play
    puts "Choose a space to attack (e.g. 0, 0)"
    print "> "
    pos = gets.chomp.delete(",!?+-/-. ").split("").map(&:to_i)
    while pos.length != 2
      puts "Invalid move: please try again"
      print "> "
      pos = gets.chomp.delete(",!?+-/- ").split("").map(&:to_i)
    end
    pos
  end

  def populate_grid
    puts "Below is your board. Please choose where you would like to place your ships."
    puts "There are 5 ships in total with lengths of 5, 4, 3, 3, and 2."
    puts "We will go through the ships one at a time. Indicate where you would like"
    puts "to place the ships by typing in the starting and ending coordinates, separated"
    puts "by a comma. For example (0, 0), (3, 0). Note that ships may only be placed"
    puts "horizontally or vertically and ships may not overlap."
    board.display
    board.add_ships(self)
  end

end
