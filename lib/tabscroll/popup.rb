
require_relative 'screen.rb'

# A simple centralized popup on the terminal.
class Popup < Screen

  # Creates a Popup with `title` and inner `text`.
  #
  # It resizes to contain the whole text plus a 1x1 border
  # around itself.
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

  # Makes the Popup appear on the screen and wait for any key.
  # When it exits, clears the screen erasing itself.
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

