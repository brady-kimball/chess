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
