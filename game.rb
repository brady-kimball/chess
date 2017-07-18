require_relative 'display'
require_relative 'board'
require_relative 'human_player'

class Game

  def initialize(player1, player2, board = Board.new)
    @board = board
    @display = Display.new(@board)
    @players = [
      HumanPlayer.new(player1, @display, :w),
      HumanPlayer.new(player2, @display, :b)
    ]
  end

  def play
    start_game

    until winner
      @display.cursor.reset(current_player.color)
      @display.render("#{current_player.color_str}'s turn:")
      process_player_move
      switch_players!
    end
    @display.render("#{winner} wins!!!!!!".blink)
  end

  def current_player
    @players[0]
  end

  private

  def start_game
    system('clear')
    puts "Welcome to chess."
    puts
    puts "#{@players[0].name} is #{@players[0].color_str.colorize(:cyan).underline}"
    puts "#{@players[1].name} is #{@players[1].color_str.underline}"
    puts
    puts "Press :enter to continue."
    gets
  end

  def process_player_move
    start_pos, end_pos = current_player.make_move
    puts "#{@board.pos_to_str(start_pos)} to #{@board.pos_to_str(end_pos)}"
    sleep(0.5)
    @board.move_piece(start_pos, end_pos)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def switch_players!
    @players.reverse!
  end

  def winner
    if @board.checkmate?(:w)
      "Black"
    elsif @board.checkmate?(:b)
      "Cyan"
    else
      false
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new("P1", "P2").play
end
