class King < Piece
  include SteppingPiece

  def symbol
    9812
    # :K
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
