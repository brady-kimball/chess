require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system("clear")
    tr = ('a'..'h').to_a.map { |l| l.colorize(:blue) }.join(" ")
    puts "  " + tr

    0.upto(7).each do |row|
      print "#{row.to_s.colorize(:blue)} "
      #  print "#{idx_str} #{row.map(&:to_s).join(' ')}"

      0.upto(7).each do |col|
        color = @cursor.selected ? :red : :green
        pos = [row, col]
        print_str = board[pos].to_s
        print_str = print_str.colorize(color) if pos == @cursor.cursor_pos
        print "#{print_str} "
      end
      print "\n"
    end

    puts
  end

  def move(new_pos)
    @board.move_piece(@cursor.cursor_pos, new_pos)
  end
end
