require_relative 'pieces/all_pieces'

class Board

  def initialize(grid = nil)
    @grid = grid || make_starting_grid
  end

  # Board Access / Search

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def pos_to_str(pos)
    row, col = pos
    letter = ("a".."h").to_a[col]
    num = 8 - row
    letter + num.to_s
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  # Board modification

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = NullPiece.instance
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]

    if piece == NullPiece.instance
      raise "No piece at start_pos: #{pos_to_str(start_pos)}"
    elsif !piece.valid_moves.include?(end_pos)
      raise "Can't move to end_pos: #{pos_to_str(end_pos)}"
    end

    self[end_pos] = piece
    self[end_pos].pos = end_pos
    self[start_pos] = NullPiece.instance
  end

  def in_check?(color)
    opp_color = color == :w ? :b : :w
    king_pos = find_king(color)

    get_pieces(opp_color).any? do |piece|
      piece.moves.include?(king_pos)
      piece.pos if piece.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    pieces = get_pieces(color)
    in_check?(color) && pieces.all? { |pc| pc.valid_moves.empty? }
  end

  def dup
    dupped = Board.new(Array.new(8) { Array.new(8, NullPiece.instance) })

    (0..7).to_a.repeated_permutation(2) do |row, col|
      pos = [row, col]
      old_piece = self[pos]
      next if old_piece.is_a?(NullPiece)
      dupped[pos] = old_piece.class.new(dupped, pos, old_piece.color)
    end

    dupped
  end

  private

  def find_king(color)
    (0..7).to_a.repeated_permutation(2) do |row, col|
      pos = [row, col]
      piece = self[pos]
      return pos if piece.is_a?(King) && piece.color == color
    end
  end

  def get_pieces(color)
    @grid.flatten.select { |piece| piece.color == color }
  end

  protected

  def make_starting_grid
    grid = Array.new(8) { Array.new(8, NullPiece.instance) }

    grid[0][0] = Rook.new(self, [0, 0], :b)
    grid[0][1] = Knight.new(self, [0, 1], :b)
    grid[0][2] = Bishop.new(self, [0, 2], :b)
    grid[0][3] = Queen.new(self, [0, 3], :b)
    grid[0][4] = King.new(self, [0, 4], :b)
    grid[0][5] = Bishop.new(self, [0, 5], :b)
    grid[0][6] = Knight.new(self, [0, 6], :b)
    grid[0][7] = Rook.new(self, [0, 7], :b)
    grid[7][0] = Rook.new(self, [7, 0], :w)
    grid[7][1] = Knight.new(self, [7, 1], :w)
    grid[7][2] = Bishop.new(self, [7, 2], :w)
    grid[7][3] = Queen.new(self, [7, 3], :w)
    grid[7][4] = King.new(self, [7, 4], :w)
    grid[7][5] = Bishop.new(self, [7, 5], :w)
    grid[7][6] = Knight.new(self, [7, 6], :w)
    grid[7][7] = Rook.new(self, [7, 7], :w)

    8.times do |n|
      grid[1][n] = Pawn.new(self, [1, n], :b)
      grid[6][n] = Pawn.new(self, [6, n], :w)
    end

    grid
  end
end
