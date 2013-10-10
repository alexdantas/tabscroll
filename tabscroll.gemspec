# Adding lib directory to load path
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

require 'tabscroll/version'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'tabscroll'
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

  # Including everything that's on `git`
  s.files       = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = { 'github' => 'http://www.github.com/alexdantas/tabscroll' }

  s.add_development_dependency "rake"
end

