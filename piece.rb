require 'singleton'
require_relative 'move_modules'

class Piece
  def initialize(board, pos)
    @board = board
    @pos = pos
  end

  def empty?
    false
  end

  def to_s
    "p"
  end
end

class Rook < Piece
  include SlidingPiece

  # def move_dirs


end

end

class NullPiece < Piece
  include Singleton

  def empty?
    true
  end

  def to_s
    "_"
  end
end
