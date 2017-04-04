require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board, :cursor, :selected_array

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @selected_array = []
  end

  def render
    system("clear")
    tr = ('a'..'h').to_a.map { |l| l.colorize(:blue) }.join(" ")
    puts "  " + tr

    0.upto(7).each do |row|
      print "#{(8 - row).to_s.colorize(:blue)} "
      #  print "#{idx_str} #{row.map(&:to_s).join(' ')}"

      0.upto(7).each do |col|
        pos = [row, col]
        print_str = board[pos].to_s
        print_str = print_str.colorize(:green) if pos == @cursor.cursor_pos
        print_str = print_str.colorize(:red) if pos == @selected_array[0]
        print "#{print_str} "
      end
      print "#{(8 - row).to_s.colorize(:blue)}\n"
    end

    puts "  " + tr
  end

  def update
    if selected?
      @selected_array << @cursor.cursor_pos
      @cursor.toggle_selected
    end
    render
    puts @selected_array.map { |arr| @board.pos_to_str(arr) }.join(" to ")
    sleep(0.3) if @selected_array.length == 2
  end

  def clear_selected_array
    @selected_array = []
  end

  def selected?
    @cursor.selected
  end

end

# until @selected_array.length == 2
#   key = KEYMAP[read_char]
#   handle_key(key)
#   if @selected
#     if @selected_array[0] == cursor_pos
#       @selected_array.pop
#     else
#       @selected_array << @cursor_pos
#     end
#     toggle_selected
#   end
# end





if __FILE__ == $PROGRAM_NAME
  a = Display.new(Board.new);
  b = a.board;
  #b[[1, 3]] = NullPiece.instance
  #b.move_piece([0,3],[6,3])
  a.render

moves = [[[1,5],[2,5]],
  [[6,4],[4,4]],
  [[1,6],[3,6]],
  [[7,3],[3,7]]]


  moves.each do |start, end_pos|
    b.move_piece(start, end_pos)
    a.render
    gets
  end
  p b.checkmate?(:w)
  p b.checkmate?(:b)

end
