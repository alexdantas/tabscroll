# My awesome Rakefile

require_relative 'lib/tabscroll'

task :build do
  system 'gem build tabscroll.gemspec'
end

task :release => :build do
  system "gem push tabscroll-#{TabScroll::VERSION}"
end

