require 'lib/fuzzy_set'

class RightShoulder < FuzzySet

  attr_reader :left, :peak, :right

  def initialize(left, peak, right)
    # TODO validations

    @peak         = peak
    @left         = left
    @right        = right
    @left_subdiv  = 1.0 / (@peak - @left)
  end

  def dom(value)
    if value > @peak
      1.0
    elsif value > @left
      (value - @left) * @left_subdiv
    else
      0.0
    end
  end

end
