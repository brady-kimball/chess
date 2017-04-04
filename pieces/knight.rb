class Knight < Piece
  include SteppingPiece

  def symbol
    :N
  end

  protected

  def move_diffs
    diffs = []

    (-2..2).each do |i|
      next if i == 0
      (-2..2).each do |j|
        next if j == 0 || i == j || i + j == 0
        diffs << [i, j]
      end
    end

    diffs
  end
end
