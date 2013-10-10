# A simple timer that counts in seconds.
#
# Usage:
#     timer = Timer.new
#     timer.start
#     ...
#     if timer.delta > 0.5 # half a second
#         ...
#
class Timer

  # Creates the timer, doing nothing else.
  def initialize
    @is_running = false
    @is_paused  = false
  end

  # Starts counting.
  def start
    return if @is_running

    @start_time  = Time.now
    @stop_time   = 0.0
    @paused_time = 0.0
    @is_running  = true
    @is_paused   = false
  end

  # Stops counting.
  def stop
    return if not @is_running

    @stop_time  = Time.now
    @is_running = false
    @is_paused  = false
  end

  def restart
    self.stop
    self.start
  end

  def pause
    return if not @is_running or @is_paused

    @paused_time = (Time.now - @start_time)
    @is_running  = false
    @is_paused   = true
  end

  def unpause
    return if not @is_paused or @is_running

    @start_time = (Time.now - @paused_time)
    @is_running = true
    @is_paused  = false
  end

  def running?
    @is_running
  end

  def paused?
    @is_paused
  end

  # Returns the current delta in seconds (float).
  def delta
    if @is_running
      return (Time.now.to_f - @start_time.to_f)
    end

    return @paused_time.to_f if @is_paused

    return @start_time if @start_time == 0 # Something's wrong

    return (@stop_time.to_f - @start_time.to_f)
  end

  # Converts the timer's delta to a formatted string.
  def to_s
    min  = (self.delta / 60).to_i
    sec  = (self.delta).to_i
    msec = (self.delta * 100).to_i

    "#{min}:#{sec}:#{msec}"
  end
end

