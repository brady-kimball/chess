class Player
  attr_reader :color, :name

  def initialize(name, display, color)
    @display = display
    @cursor = display.cursor
    @name = name
    @color = color
  end

  def update_display
    header = "#{color_str}'s turn:"
    @display.render(header)
  end

  def color_str
    color == :w ? "White" : "Black"
  end

end
