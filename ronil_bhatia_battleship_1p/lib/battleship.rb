require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player, :player_board

  def initialize(player = HumanPlayer.new("Ronil"), board = Board.new)
    @board = board
    @player = player
    @player_board = Board.new
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def attack(pos)
    if board[pos] == :s
      puts "Hit!"
      board[pos] = :x
      player_board[pos] = :s
    else
      puts "Miss!"
      board[pos] = :x
      player_board[pos] = :x
    end
  end

  def play_turn
    pos = player.get_play
    if player_board.empty?(pos)
      attack(pos)
      player_board.display
      nil
    else
      puts "Spot already selected, please try again"
      play_turn
    end
  end

  def play
    board.populate_grid
    player_board.display
    play_turn until game_over?
    puts "Congratulations, you win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = BattleshipGame.new
  game.play
end
