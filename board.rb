require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = make_starting_grid
  end

  def null_piece
    NullPiece.instance
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]

    if piece == null_piece
      raise "No piece at start_pos: #{start_pos}"
    elsif false #!piece.can_move_to?(end_pos)
      raise "Can't move to end_pos: #{end_pos}"
    end

    self[end_pos] = piece
    self[start_pos] = null_piece
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,val)
    row, col = pos
    @grid[row][col] = val
  end

  protected

  def make_starting_grid
    white_pieces = Array.new(2) { Array.new(8) { Piece.new } }
    black_pieces = Array.new(2) { Array.new(8) { Piece.new } }
    empties = Array.new(8) { Array.new(8, NullPiece.instance) }

    white_pieces + empties + black_pieces
  end

end
