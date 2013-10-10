
require 'tabscroll/screen'
require 'tabscroll/timer'

# A full guitar tab, as shown on the screen.
# Note that it depends on an already-existing window to exist.
#
class Track

  # Any line on the file that starts with this char is completely
  # ignored when processed.
  # Useful for making use of tabs we currently can't parse.
  COMMENT_CHAR = '#'

  attr_reader :screen, :percent_completed
  attr_accessor :speed

  # Creates a Track that will be shown on `screen`.
  # See Screen.
  def initialize(screen)
    @offset = 0
    @timer  = Timer.new
    @timer.start
    @speed  = 0
    @screen = screen
    @percent_completed = 0

    @raw_track = []
    @raw_track[0] = ""
    @raw_track[1] = ""
    @raw_track[2] = ""
    @raw_track[3] = ""
    @raw_track[4] = ""
    @raw_track[5] = ""
    @raw_track[6] = ""
  end

  # Loads and parses +filename+'s contents into Track.
  def load filename
    if not File.exist? filename
      raise "Error: File '#{filename}' doesn't exist!"
    end
    if not File.file? filename
      raise "Error: '#{filename}' is not a file!"
    end

    file = File.new filename

    # The thing here is there's no way I can know in
    # advance how many lines the tab track will have.
    #
    # People put lots of strange things on them like
    # timing, comments, etecetera.
    #
    # So I will read all non-blank lines, creating a
    # counter. Then I will use it to display the track
    # onscreen.
    #
    # I will also make every line have the same width
    # as of the biggest one.

    # Any tab line MUST have EITHER ---1---9--| OR |---3----0
    tab_line = /[-[:alnum:]]\||\|[-[:alnum:]]/

    # Duration of each note only has those chars.
    # So we look for anything BUT these chars.
    not_duration_line = /[^WHQESTX \.]/

    count = 0
    max_width = 0

    file.readlines.each do |line|
      next if line[0] == COMMENT_CHAR

      line.chomp!
      if line.empty?

        # Making sure everything will have the same width
        @raw_track.each_with_index do |t, i|
          if t.length < max_width
            @raw_track[i] += (' ' * (max_width - t.length))
          end
        end

        count = 0
        max_width = 0

      # Lines must be EITHER a tab_line OR a duration_line.
      # not not duration line means that
      # (I should find a better way of expressing myself on regexes)
      elsif (line =~ tab_line) or (not line =~ not_duration_line)
        @raw_track[count] += line

        if @raw_track[count].length > max_width
          max_width = @raw_track[count].length
        end

        count += 1

      end # Ignoring any other kind of line

      if count > 7
        raise "Error: Invalid format on '#{filename}'"
      end

    end
  end

  # Prints the track on the screen, along with string indicators
  # on the left.
  #
  # It is shown at the vertical center of the provided Screen,
  # spanning it's whole width.
  def show
    x = 1
    y = (@screen.height/2) - (@raw_track.size/2)

    # This both prints EADGBE and clears the whole screen,
    # printing spaces where the track was.
    #
    # Also, if we have only 5 tracks, we leave the sixth
    # indicator out of the screen.
    if @raw_track.last =~ /^ *$/
      @screen.mvaddstr(0, y,     "E" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 1, "B" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 2, "G" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 3, "D" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 4, "A" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 5, "E" + (' ' * (@screen.width - 1)))
    else
      @screen.mvaddstr(0, y,     ' ' * @screen.width)
      @screen.mvaddstr(0, y + 1, "E" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 2, "B" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 3, "G" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 4, "D" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 5, "A" + (' ' * (@screen.width - 1)))
      @screen.mvaddstr(0, y + 6, "E" + (' ' * (@screen.width - 1)))
    end

    (0...@raw_track.size).each do |i|
      str = @raw_track[i]
      str = str[@offset..(@offset + @screen.width - 2)]
      @screen.mvaddstr(x, y + i, str)
    end
  end

  # Scrolls the guitar tab by `n`.
  #
  # * If `n` is positive, scroll forward.
  # * If `n` is negative, scroll backward.
  def scroll n
    @offset += n

    left_limit  = 0
    right_limit = (@raw_track[0].length - @screen.width + 1).abs

    if @offset < left_limit  then @offset = left_limit  end
    if @offset > right_limit then @offset = right_limit end
  end

  # Goes to the beginning of the Track.
  def begin
    @offset = 0
    @speed  = 0
  end

  # Goes to the end of the Track.
  def end
    @offset = (@raw_track[0].length - @screen.width + 1).abs
    @speed  = 0
  end

  # Turns on/off Track's auto scroll functionality.
  #
  # Note that it won't work anyways if you don't keep calling
  # +update+ method.
  def auto_scroll option
    if option == true
      @timer.start if not @timer.running?
    else
      @timer.stop
    end
  end

  # Updates Track's auto scroll functionality.
  def update
    return if not @timer.running?

    current_completed = @offset + @screen.width - 1
    @percent_completed = ((100.0 * current_completed)/@raw_track[0].length).ceil

    if @timer.running? and @speed != 0
      if @timer.delta > (1/(@speed*0.5)).abs
        if @speed > 0
          self.scroll 1
          self.show
        else
          self.scroll -1
          self.show
        end

        @timer.restart
      end
    end
  end

end

