require_relative 'display'
require_relative 'board'
#require_relative 'player'

class Game
  def initialize(player1, player2, board = Board.new)
    @board = board
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(player1, @display)
    @player2 = HumanPlayer.new(player2, @display)
  end


end
