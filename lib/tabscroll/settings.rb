
require 'optparse'
require 'tabscroll'

# Global configurations of the program, along with a commandline
# argument parser.
#
# Contains the program's specific configuration rules.
class Settings

  # Creates a configuration, with default values.
  def initialize
    @settings = {}
    @settings[:filename] = nil

    # We have a way to test the program.
    # We're distributing a sample tab file with the Gem so
    # when users run `tabscroll --sample` they can see
    # how the program works.
    # This setting enables it
    @settings[:run_sample_file] = false

    # And this is the absolute filename of the file
    # distributed with the gem.
    # It'll be `../../sample_tab.txt` based on `settings.rb` path.
    filename = File.expand_path("../../", __FILE__)
    filename = File.dirname filename
    filename += "/sample_tab.txt"
    @settings[:sample_filename] = filename
  end

  # Sets options based on commandline arguments `args`.
  # It should be `ARGV`.
  def parse args

    opts = OptionParser.new do |parser|
      parser.banner = "Usage: tabscroll [options] filename"

      # Make output beautiful
      parser.separator ""
      parser.separator "Options:"

      parser.on("--sample", "Run `tabscroll` with sample file") do
        @settings[:run_sample_file] = true
      end

      # These options appear if no other is given.
      parser.on_tail("-h", "--help", "Show this message") do
        puts parser
        exit
      end

      parser.on_tail("--version", "Show version") do
        puts "tabscroll v#{TabScroll::VERSION}"
        exit
      end
    end
    opts.parse! args

    # After parsing all dashed arguments we will check if
    # the user has provided a filename.
    #
    # The first argument without a leading '-' will be
    # considered.
    args.each do |arg|
      if arg =~ /^[^-]/
        @settings[:filename] = arg
        break
      end
    end

    if not @settings[:filename] and not @settings[:run_sample_file]
      puts opts
      exit 666
    end

    return @settings
  end

  # Returns a specific setting previously set.
  def [] name
    return @settings[name]
  end
end

