
require 'optparse'
require_relative '../tabscroll'

# Global configurations of the program, along with a commandline
# argument parser.
#
# Contains the program's specific configuration rules.
class Settings

  # Creates a configuration, with default values.
  def initialize
    @settings = {}
    @settings[:filename] = nil
  end

  # Sets options based on commandline arguments `args`.
  # It should be `ARGV`.
  def parse args

    opts = OptionParser.new do |parser|
      parser.banner = "Usage: #{TabScroll::NAME} [options] filename"

      # Make output beautiful
      parser.separator ""
      parser.separator "Specific options:"

      parser.on_tail("-h", "--help", "Show this message") do
        puts parser
        exit
      end

      parser.on_tail("--version", "Show version") do
        puts "#{TabScroll::NAME} v#{TabScroll::VERSION}"
        exit
      end
    end
    opts.parse! args

    # After parsing all '--args' and '-a' we will check if
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

    if not @settings[:filename]
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

