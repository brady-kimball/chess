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
