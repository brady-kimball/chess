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
