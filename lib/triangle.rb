require 'lib/fuzzy_set'

class Triangle < FuzzySet

  attr_reader :left, :center, :right, :height

  def initialize(left, center, right, height=1.0)
    # TODO validations

    @center = center.to_f
    @left   = left.to_f
    @right  = right.to_f
    @height = height.to_f
  end

  def mu(value)
    if value < @left || value > @right
      0.0
    else
      1 - ((@center-value).abs / ((@right - @left) / 2.0 ))
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
    "Triangle {#{@left}/#{@center}/#{@right}, height #{@height}}"
  end

end
