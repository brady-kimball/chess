class Queen < Piece
  include SlidingPiece

  def symbol
    9813
    # :Q
  end

  protected

  def move_dirs
    [:horizontal, :vertical, :diagonal]
  end
end
