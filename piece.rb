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

  def symbol
    :p
  end

  def to_s
    symbol
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

class NullPiece < Piece
  include Singleton

  def empty?
    true
  end

  def symbol
    :_
  end
end
