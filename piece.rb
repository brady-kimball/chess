require 'singleton'
require_relative 'move_modules'

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
    if @color == :b
      str.underline
    else
      str
    end
  end
end

class Rook < Piece
  include SlidingPiece

  def symbol
    :R
  end

  protected

  def move_dirs
    [:horizontal, :vertical]
  end
end

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

class King < Piece
  include SteppingPiece

  def symbol
    :K
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

class Pawn < Piece
  def symbol
    :P
  end

  def moves
    forward_moves + side_attacks
  end

  def at_start_row?
    @color == :w ? pos[0] == 6 : pos[0] == 1
  end

  def forward_dir
    @color == :w ? -1 : 1
  end

  def forward_steps
    at_start_row? ? 2 : 1
  end

  def forward_moves
    valid_moves = []

    curr_row, curr_col = @pos

    forward_steps.times do |step_size|
      next_pos = [curr_row + forward_dir * (step_size + 1), curr_col]
      if @board.in_bounds?(next_pos) && @board[next_pos].empty?
        valid_moves << next_pos
      end
    end

    valid_moves
  end

  def side_attacks
    curr_row, curr_col = @pos
    side_moves = [
      [curr_row + forward_dir, curr_col + 1],
      [curr_row + forward_dir, curr_col - 1]
    ]

    side_moves.select do |move|
      @board.in_bounds?(move) &&
        !@board[move].empty? &&
        @board[move].color != color
    end
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def empty?
    true
  end

  def to_s
    "_"
  end
end
