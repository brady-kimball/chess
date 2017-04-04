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
