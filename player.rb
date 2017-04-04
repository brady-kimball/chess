class Player
  def initialize(name, display)
    @display = display
    @name = name
  end

  def play_turn
    @display.render
  end
end

class HumanPlayer < Player
  def make_move
    @display.clear_selected_array
    @display.render

    until @display.selected_array.length == 2
      @display.cursor.get_input
      @display.update
    end

    @display.selected_array
  end
end
