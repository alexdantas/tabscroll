# The main executable file.

require 'tabscroll/engine'
require 'tabscroll/screen'
require 'tabscroll/track'
require 'tabscroll/popup'
require 'tabscroll/version'

# The main program.
#
# Note that we expect a global hash `$settings`.
# It contains settings from the commandline argument parser
# (Settings class).
module TabScroll

  # Executes the whole program, loading contents in `filename`.
  def self.run filename
    @engine = Engine.new
    if not @engine
      puts 'Failed to start curses!'
      exit 1337
    end
    @engine.timeout 10

    win = Screen.new(0, 1, @engine.width, @engine.height - 2)
    track = Track.new win
    track.load filename
    track.auto_scroll true

    titlebar  = Screen.new(0, 0, @engine.width, 1)
    statusbar = Screen.new(0, (@engine.height - 1), @engine.width, 1)

    bars_hidden = false
    finished = false
    while not finished

      # WHY DOES GETCH CLEARS UP THE WHOLE SCREEN?
      # IT DOESNT MAKE ANY SENSE
      c = @engine.getchar
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
      when '<'
        track.scroll -5
      when '>'
        track.scroll 5
      when Curses::KEY_LEFT
        track.speed -= 1
      when Curses::KEY_RIGHT
        track.speed += 1
      when Curses::KEY_DOWN, Curses::KEY_UP
        track.speed = 0
      when 'q'
        $enigne.exit
        return nil
      end

      track.update
      track.show
      if not bars_hidden
        titlebar.mvaddstr(0, 0, "#{filename} (#{track.percent_completed}%) ", Engine::Colors[:cyan])
        titlebar.mvaddstr_right(0, "  Speed: #{track.speed}", Engine::Colors[:cyan])

        statusbar.mvaddstr_left(0, "tabscroll v#{VERSION} - press `h` for help", Engine::Colors[:green])
      end
    end

    @engine.exit
    return nil
  end

  # Displays a help window that waits for a keypress.
  def self.show_help_window
    title = 'Help'
    text  = <<END_OF_TEXT
         q  quit
         h  help/go back
left/right  auto-scroll left/right
   up/down  stop auto-scrolling
       </>  step scroll left/right
         o  toggle status/title bars


tabscroll v#{VERSION}
homepage  alexdantas.net/projects/tabscroll
author    Alexandre Dantas <eu@alexdantas.net>
END_OF_TEXT

    pop = Popup.new(title, text)
    will_quit = pop.show
    quit if will_quit
  end
end

