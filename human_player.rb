require_relative 'player'

class HumanPlayer < Player
  def make_move
    positions = []

    until positions.length == 2
      @cursor.get_input
      pos = @cursor.cursor_pos

      if selected?
        if positions.empty? && @display.board[pos].color != color
          @cursor.toggle_selected
          raise "Pick your own color!"
        end

        if pos == positions[0]
          positions = []
        else
          positions << pos
        end
        @cursor.toggle_selected
      end
      update_display(positions)
    end

    positions
  end

  def update_display(positions)
    super()
    puts @display.board.pos_to_str(positions[0]) if positions.length == 1
  end

  def selected?
    @display.cursor.selected
  end

end
