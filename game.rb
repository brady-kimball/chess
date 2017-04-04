require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :display

  def initialize(player1 = 'b', player2 = 'n', board = Board.new)
    @board = board
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(player1, @display)
    @player2 = HumanPlayer.new(player2, @display)
  end

  def play
    until over?
      begin
        start_pos, end_pos = @player1.make_move
        @board.move_piece(start_pos, end_pos)
      rescue RuntimeError => e
        puts e.message
        sleep(1)
        retry
      end

    end
  end

  def over?
    @board.checkmate?(:w) || @board.checkmate?(:b)
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
