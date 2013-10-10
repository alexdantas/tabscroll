# Adding lib directory to load path
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

require 'tabscroll/version'

task :build do
  system 'gem build tabscroll.gemspec'
end

task :release => :build do
  system "gem push tabscroll-#{TabScroll::VERSION}.gem"
end

