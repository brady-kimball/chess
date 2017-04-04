class NullPiece < Piece
  include Singleton

  def initialize; end

  def empty?
    true
  end

  def to_s
    "_"
  end
end
