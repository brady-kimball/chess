class Bishop < Piece
  include SlidingPiece

  def symbol
    9815
    #:B
  end

  protected

  def move_dirs
    [:diagonal]
  end
end
