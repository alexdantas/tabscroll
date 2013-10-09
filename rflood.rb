#
#
#

require 'engine.rb'
require 'classes.rb'

begin
  engine = Engine.new(80, 24)
  ok = engine.init
  exit if not ok

  board = Board.new(14, 14)
  engine.drawUI
  engine.drawBoard(board)

  c = ''
  while not (c = engine.getchar.chr) == 'q'
    case c
    when nil
      break
    when '1'
      board.flood Color::WHITE_BLUE, 0, 0
    when '2'
      board.flood Color::WHITE_RED
    when '3'
      board.flood Color::WHITE_CYAN
    when '4'
      board.flood Color::WHITE_GREEN
    when '5'
      board.flood Color::WHITE_YELLOW
    when '6'
      board.flood Color::WHITE_MAGENTA
    end
  end

  engine.exit
end

