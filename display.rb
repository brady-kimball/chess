require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board

  def initialize(board)
    @board = board
  end

  

end
