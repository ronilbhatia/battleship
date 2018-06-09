require_relative 'board'
require_relative 'player'
require_relative 'computer_player'

class BattleshipGame
  attr_reader :human, :computer, :current_player, :other_player

  def initialize(human = HumanPlayer.new("Ronil"), computer = ComputerPlayer.new)
    @human = human
    @computer = computer
    @current_player = human
    @other_player = computer
  end

  def count(player)
    player.board.count
  end

  def game_over?
    human.board.won? || computer.board.won?
  end

  def attack(pos)
    if other_player.board[pos] == :s
      puts "Hit!"
      other_player.board[pos] = :x
      current_player.tracking_board[pos] = :s
    else
      puts "Miss!"
      other_player.board[pos] = :x
      current_player.tracking_board[pos] = :x
    end
  end

  def play_turn
    pos = current_player.get_play
    if current_player.tracking_board.empty?(pos)
      attack(pos)
      if current_player == human
        puts "You attacked space #{pos}. This is your tracking board:"
        human.tracking_board.display_tracking
      else
        puts "The computer attacked space #{pos}. This is your board:"
        human.board.display
      end
      nil
    else
      puts "Spot already selected, please try again"
      play_turn
    end

    switch_players
  end

  def play
    print "\nWelcome to battleship. You will be playing against a computer\n"
    print "who will be guessing the location of your ships. At the same time,\n"
    print "you will be trying to guess the position of theirs. The first to\n"
    print "successfully destroy the others ships will be the winner. Good luck!\n\n"
    setup
    puts "This is your tracking board - use it to track all attacks you have made:\n"
    human.tracking_board.display_tracking
    play_turn until game_over?
    puts "#{other_player.name} wins!"
  end

  def setup
    human.populate_grid
    computer.board.populate_grid
  end

  def switch_players
    @current_player, @other_player = other_player, current_player
  end
end

if __FILE__ == $PROGRAM_NAME
  game = BattleshipGame.new
  game.play
end
