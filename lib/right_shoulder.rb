require 'lib/fuzzy_set'

class RightShoulder < FuzzySet

  attr_reader :left, :peak, :right, :height

  def initialize(left, peak, right, height=1.0)
    # TODO validations

    @peak         = peak
    @left         = left
    @right        = right
    @height       = height
    @left_subdiv  = @height / (@peak - @left)
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

  def height=(new_height)
    @height       = new_height
    @left_subdiv  = @height / (@peak - @left)
  end

  def scale(percentage)
    t = self.dup
    t.height=(t.height * percentage)
    t
  end

  def to_s
    "RightShoulder {#{left}/#{peak}/#{right}, height #{height}}"
  end
end
