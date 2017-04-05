class Rook < Piece
  include SlidingPiece

  def symbol
    9814
    #  :R
  end

  protected

  def move_dirs
    [:horizontal, :vertical]
  end
end
