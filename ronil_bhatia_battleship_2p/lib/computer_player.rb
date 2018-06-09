class ComputerPlayer
  attr_reader :name, :board, :tracking_board

  def initialize(name = "Computer")
    @name = name
    @board = Board.new
    @tracking_board = Board.new
    @guessed_spaces = []
  end

  def get_play
    guess = false
    while guess == false
      random_guess = [rand(board.grid.length), rand(board.grid.length)]
      guess = random_guess unless @guessed_spaces.include?(random_guess)
    end
    @guessed_spaces << guess

    guess
  end

end
