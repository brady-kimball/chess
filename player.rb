class Player
  attr_reader :color, :name

  def initialize(name, display, color)
    @display = display
    @cursor = display.cursor
    @name = name
    @color = color
  end

  def update_display(positions = [])
    header = "#{color_str}'s turn:"
    @display.render(header, positions)
  end

  def color_str
    color == :w ? "Cyan" : "Black"
  end

end
