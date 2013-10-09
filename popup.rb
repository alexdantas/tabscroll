
require_relative 'screen.rb'

# A simple centralized popup.
#
# It resizes as you place the text on it.
class Popup < Screen

  def initialize(title, text)
    @title = title
    @text = []
    text.each_line do |line|
      @text += [line.chomp]
    end

    max_width  = title.length
    max_height = 1

    @text.each do |line|
      max_width   = line.length if line.length > max_width
      max_height += 1
    end

    max_width  += 2 # left-right borders
    max_height += 1 # down border

    x = Curses::cols/2  - max_width/2
    y = Curses::lines/2 - max_height/2

    super(x, y, max_width, max_height)
    self.background ' '
    self.box

    self.mvaddstr_center(0, title, Engine::Colors[:cyan])

    y = 1
    @text.each do |line|
      self.mvaddstr(1, y, line)
      y += 1
    end
  end

  def show
    finished = false
    while not finished
      c = Curses::getch
      case c
      when 'q'
        return true
      when 'h'
        finished = true
      end
    end

    Curses::stdscr.clear
    Curses::stdscr.refresh
    return false
  end
end

