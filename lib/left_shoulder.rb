require 'lib/fuzzy_set'

class LeftShoulder < FuzzySet

  attr_accessor :peak, :left_offset, :right_offset

  def initialize(peak, left_offset, right_offset)
    if left_offset < 0 || right_offset < 0
      raise ArgumentError, "offsets cannot be negative"
    end
    @peak         = peak
    @left_offset  = left_offset
    @right_offset = right_offset
  end

  def calculate_dom(value)
    if @right_offset==0 && @left_offset==0
      return 1.0
    end

    if value >= @peak && value <= (@peak + @right_offset)
      subdiv = 1.0 / -@right_offset
      return subdiv * (value - @peak) + 1.0
    end

    if value < @peak
      return 1.0
    end

    return 0.0
  end

end
