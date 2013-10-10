# The main executable file.

require_relative 'tabscroll/engine'
require_relative 'tabscroll/screen'
require_relative 'tabscroll/track'
require_relative 'tabscroll/popup'

# Global vars
$engine = nil
PROGRAM_NAME    = "tabscroll"
PROGRAM_VERSION = "0.0.1"

# Terminates program's execution normally, finishing the engine.
def quit
  $engine.exit
  exit 0
end

# Displays a help window, waiting for a keypress.
def show_help_window
  title = 'Help'
  text  = <<END_OF_TEXT
         q  quit
         h  help/go back
left/right  auto-scroll left/right
   up/down  stop auto-scrolling
       </>  step scroll left/right
         o  toggle status/title bars


#{PROGRAM_NAME} v#{PROGRAM_VERSION}
homepage  alexdantas.net/projects/tabscroll
author    Alexandre Dantas <eu@alexdantas.net>
END_OF_TEXT

  pop = Popup.new(title, text)
  will_quit = pop.show
  quit if will_quit
end

