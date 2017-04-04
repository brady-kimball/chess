class Player
  def initialize(name, display)
    @display = display
    @cursor = display.cursor
    @name = name

  end

  def play_turn
    @display.render
  end
end

class HumanPlayer < Player
  def make_move
    positions = []

    until positions.length == 2
      @display.render(positions)
      puts positions.map { |arr| @display.board.pos_to_str(arr) }.join(" to ")

      @cursor.get_input
      if selected?
        positions << @cursor.cursor_pos
        @cursor.toggle_selected
      end
    end

    sleep(0.3)
    positions
  end

  def selected?
    @display.cursor.selected
  end


end
