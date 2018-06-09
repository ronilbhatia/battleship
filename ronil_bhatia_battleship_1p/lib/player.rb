class HumanPlayer
  def initialize(player)
    @player = player
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
end
