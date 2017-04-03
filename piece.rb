require 'singleton'

class Piece


end

class NullPiece < Piece
  include Singleton

  def initialize
  end

end
