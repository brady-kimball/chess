class Piece
  attr_accessor :pos
  attr_reader :color

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def empty?
    false
  end

  def to_s
    str = symbol.to_s
    @color == :b ? str.underline : str
  end

  def valid_moves
    moves.reject do |move|
      dupped_board = @board.dup
      dupped_board.move_piece!(pos, move)
      dupped_board.in_check?(color)
    end
  end
end
