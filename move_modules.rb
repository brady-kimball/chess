module SlidingPiece
  DIFFS = {
    horizontal: [[0,-1],[0,1]],
    vertical: [[-1,0],[1,0]],
    diagonal: [[1,1],[-1,-1],[1,-1],[-1,1]]
  }

  def moves
    # possible end_pos from self.pos

    valid_moves = []
    move_dirs.each do |dir|
      DIFFS[dir].each do |d_row, d_col|
        valid_moves += grow_unblocked_moves_in(d_row,d_col)
      end
    end

    valid_moves
  end

  private
  def horizontal_directions
    DIFFS[:horizontal]
  end

  def diagonal_directions
    DIFFS[:diagonal]
  end

  def grow_unblocked_moves_in(d_row,d_col)
    opp_color = color == :w ? :b : :w
    valid_moves = []
    curr_row, curr_col = @pos
    next_pos = [curr_row + d_row, curr_col + d_col]

    while @board.in_bounds?(next_pos) && @board[next_pos].color != color
      valid_moves << next_pos
      break if @board[next_pos].color == opp_color
      curr_row, curr_col = next_pos
      next_pos = [curr_row + d_row, curr_col + d_col]
    end

    valid_moves
  end

end

module SteppingPiece

  def moves
    valid_moves = []
    curr_row, curr_col = @pos
    move_diffs.each do |diff|
      d_row, d_col = diff
      next_pos = [curr_row + d_row, curr_col + d_col]
      if @board.in_bounds?(next_pos) && @board[next_pos].color != color
        valid_moves << next_pos
      end
    end

    valid_moves
  end

end
