require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :display

  def initialize(player1 = 'b', player2 = 'n', board = Board.new)
    @board = board
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(player1, @display, :w)
    @player2 = HumanPlayer.new(player2, @display, :b)
    @players = [@player1, @player2]
  end

  def play
    until winner
      begin
        display.render("#{current_player.color_str}'s turn:")
        start_pos, end_pos = current_player.make_move
        move_str = "#{@board.pos_to_str(start_pos)} to #{@board.pos_to_str(end_pos)}"
        puts move_str
        sleep(0.5)
        @board.move_piece(start_pos, end_pos)
      rescue RuntimeError => e
        puts e.message
        sleep(1)
        retry
      end

      switch_players!
    end
    puts "Winner is #{winner}!"
  end

  def switch_players!
    @players.reverse!
  end

  def current_player
    @players[0]
  end



  def winner
    if @board.checkmate?(:w)
      "Black"
    elsif @board.checkmate?(:b)
      "White"
    else
      false
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
