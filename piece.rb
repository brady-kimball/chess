require 'singleton'
require_relative 'move_modules'

class Piece
  attr_accessor :pos

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def empty?
    false
  end

  def to_s
    str = symbol.to_s
    if @color == :b
      str.underline
    else
      str
    end
  end
end

class Rook < Piece
  include SlidingPiece

  def symbol
    :R
  end

  protected

  def move_dirs
    [:horizontal, :vertical]
  end
end

class Bishop < Piece
  include SlidingPiece

  def symbol
    :B
  end

  protected

  def move_dirs
    [:diagonal]
  end
end

class Queen < Piece
  include SlidingPiece

  def symbol
    :Q
  end

  protected

  def move_dirs
    [:horizontal, :vertical, :diagonal]
  end
end

class Knight < Piece
  include SteppingPiece

  def symbol
    :N
  end

  protected

  def move_diffs
    diffs = []

    (-2..2).each do |i|
      next if i == 0
      (-2..2).each do |j|
        next if j == 0 || i == j || i + j == 0
        diffs << [i, j]
      end
    end

    diffs
  end
end

class King < Piece
  include SteppingPiece

  def symbol
    :K
  end

  protected

  def move_diffs
    diffs = []
    (-1..1).each do |i|
      (-1..1).each do |j|
        diffs << [i, j] unless i == 0 && j == 0
      end
    end

    diffs
  end
end

class Pawn < Piece
  def symbol
    :P
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def empty?
    true
  end

  def to_s
    "_"
  end
end
