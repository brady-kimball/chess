require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render(title = "", selected_array = [])
    system("clear")
    puts title
    puts header_footer

    0.upto(7).each do |row|
      print row_index(row)

      0.upto(7).each do |col|
        pos = [row, col]
        print_piece(pos, selected_array)
      end

      print row_index(row) + "\n"
    end

    puts header_footer
  end

  private

  def print_piece(pos, selected_array)
    print_str = board[pos].to_s
    print_str = print_str.colorize(:green) if pos == @cursor.cursor_pos
    print_str = print_str.colorize(:red) if pos == selected_array[0]
    print "#{print_str} "
  end

  def header_footer
    "  " + ('a'..'h').to_a.map { |l| l.colorize(:blue) }.join(" ")
  end

  def row_index(row)
    "#{(8 - row).to_s.colorize(:blue)} "
  end
end
