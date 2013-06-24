require 'lib/fuzzy_set'

class LeftShoulder < FuzzySet

  attr_reader :left, :peak, :right

  def initialize(left, peak, right)
    # TODO validations

    @peak         = peak
    @left         = left
    @right        = right
    @right_subdiv = -1.0 / (@peak - @right)
  end

  def dom(value)
    if value < @peak
      1.0
    elsif value < @right
      (@right - value) * @right_subdiv
    else
      0.0
    end
  end

end
