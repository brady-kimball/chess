module SlidingPiece
  DIFFS = {
    horizontal: [[0,-1],[0,1]]
    vertical: [[-1,0],[1,0]]
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
    valid_moves = []
    curr_row, curr_col = @pos
    next_pos = [curr_row + d_row, curr_col + d_col]

    while @board[next_pos].empty?
      valid_moves << next_pos
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
      valid_moves << next_pos if @board[next_pos].empty?
    end


    valid_moves
  end

end
