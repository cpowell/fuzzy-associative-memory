require 'lib/fuzzy_set'

class Trapezoid < FuzzySet

  attr_reader :left, :top_left, :top_right, :right, :height

  def initialize(left, top_left, top_right, right, height=1.0)
    # TODO validations

    @left      = left
    @top_left  = top_left
    @top_right = top_right
    @right     = right
    @height    = height
  end

  def mu(value)
    if value < @left || value > @right
      0.0
    elsif value >= @left && value < @top_left
      (value - @left) / (@top_left - @left)
    elsif value >= @top_left && value <= @top_right
      1.0
    else
      (@right - value) / (@right - @top_right)
    end
  end

  def centroid
    cx = (@left + @right + @center) / 3.0
    cy = @height / 3.0
    [cx, cy]
  end

  def height=(new_height)
    @height = new_height
  end

  def larsen(ratio)
    t = self.dup
    t.height=(t.height * ratio)
    t
  end

  def to_s
    "Triangle {#{left}/#{center}/#{right}, height #{height}}"
  end

end
