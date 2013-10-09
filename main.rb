#
#
#

require_relative 'engine.rb'
require_relative 'screen.rb'
require_relative 'track.rb'
require_relative 'popup.rb'

$engine = nil
PROGRAM_NAME    = "tless"
PROGRAM_VERSION = "0.4"

# Terminates program's execution normally, finishing the engine.
def quit
  $engine.exit
  exit 0
end

# Displays a help window, waiting for a keypress.
def show_help_window
  title = 'Help'
  text  = <<END_OF_TEXT
      q quit
      h help/go back
   left auto-scroll left
  right auto-scroll right
up/down stop auto-scrolling
      o toggle status/title bars
END_OF_TEXT

  pop = Popup.new(title, text)
  will_quit = pop.show
  quit if will_quit
end

# "Let the rock off begin!"
begin
  filename = ARGV[0]
  if not filename
    puts "Usage:"
    puts "	$ #{PROGRAM_NAME} (filename)"
    exit 666
  end

  $engine = Engine.new
  if not $engine
    puts 'Failed to start curses!'
    exit 1337
  end
  $engine.timeout 10

  win = Screen.new(0, 1, $engine.width, $engine.height - 2)
  track = Track.new win
  track.load filename
  track.auto_scroll true

  titlebar  = Screen.new(0, 0, $engine.width, 1)
  statusbar = Screen.new(0, ($engine.height - 1), $engine.width, 1)

  bars_hidden = false
  finished = false
  while not finished
    # WHY DOES GETCH CLEARS UP THE WHOLE SCREEN?
    # IT DOESNT MAKE ANY SENSE
    c = $engine.getchar
    case c
    when 'e'
      track.end
    when 'a'
      track.begin
    when 'h'
      show_help_window
    when 'o'
      bars_hidden = (bars_hidden ? false : true)
      Curses::clear
    when Curses::KEY_LEFT
      track.speed -= 1
    when Curses::KEY_RIGHT
      track.speed += 1
    when Curses::KEY_DOWN, Curses::KEY_UP
      track.speed = 0
    when 'q'
      quit
    end

    track.update
    track.show
    if not bars_hidden
      titlebar.mvaddstr(0, 0, "#{filename} (#{track.percent_completed}%) ", Engine::Colors[:cyan])
      titlebar.mvaddstr_right(0, "  Speed: #{track.speed}", Engine::Colors[:cyan])

      statusbar.mvaddstr_left(0, "#{PROGRAM_NAME} v#{PROGRAM_VERSION} - press `h` for help", Engine::Colors[:green])
    end
  end

  quit
end

