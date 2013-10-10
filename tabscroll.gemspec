# My awesome specification

require './lib/tabscroll'
require 'date'

Gem::Specification.new do |s|
  s.name        = TabScroll::NAME
  s.version     = TabScroll::VERSION
  s.summary     = "Guitar tab scroller on the terminal"
  s.date        = "#{Date.today.year}-#{Date.today.month}-#{Date.today.day}"
  s.description = <<END_OF_DESCRIPTION
Scrolls a textual guitar tab on the terminal.
It supports forward and backwards auto-scrolling and currently
reads a nice range of guitar tabs.
END_OF_DESCRIPTION
  s.authors     = ["Alexandre Dantas"]
  s.email       = ["eu@alexdantas.net"]
  s.homepage    = 'http://www.alexdantas.net/projects/tabscroll'
  s.license     = "GPL-3.0"
  s.executables << 'tabscroll'
  s.require_path = 'lib'

  # Including everything under `bin` and `lib`
  s.files = Dir.glob("{bin, lib}/**/*") + %w{LICENSE README.md CHANGELOG.md}

  s.metadata = { 'github' => 'http://www.github.com/alexdantas/tabscroll' }
end

