
Gem::Specification.new do |s|
  s.name        = "tabscroll"
  s.version     = "0.0.1"
  s.summary     = "Guitar tab scroller on the terminal"
  s.date        = "2013-10-13"
  s.description = "Scrolls a textual guitar tab on the terminal."
  s.authors     = ["Alexandre Dantas"]
  s.email       = ["eu@alexdantas.net"]
  s.homepage    = "http://www.alexdantas.net/projects/tabscroll"
  s.license     = "GPL-3.0"
  s.executables << 'tabscroll'
  s.files       = ["lib/tabscroll.rb",
                   "lib/tabscroll/engine.rb",
                   "lib/tabscroll/screen.rb",
                   "lib/tabscroll/track.rb",
                   "lib/tabscroll/popup.rb",
                   "lib/tabscroll/timer.rb"]
end

