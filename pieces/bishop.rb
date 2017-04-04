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
