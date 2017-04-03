require 'singleton'
require_relative 'moves'

class Piece

  def initialize
  end

  def empty?
    false
  end

  def to_s
    "p"
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
