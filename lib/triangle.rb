require 'lib/fuzzy_set'

class Triangle < FuzzySet

  attr_reader :left, :peak, :right

  def initialize(left, peak, right)
    # TODO validations

    @peak         = peak
    @left         = left
    @right        = right
    @left_subdiv  = 1.0 / (@peak - @left)
    @right_subdiv = -1.0 / (@peak - @right)
  end

  def dom(value)
    if value < @left
      0.0
    elsif value < @peak
      (value - @left) * @left_subdiv
    elsif value < @right
      (@right - value) * @right_subdiv
    else
      0.0
    end
  end

end
