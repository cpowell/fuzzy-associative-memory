#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
require 'fuzzy_associative_memory/fuzzy_set'
class FuzzyAssociativeMemory::Triangle < FuzzyAssociativeMemory::FuzzySet

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

  def centroid_x
    cx = (@left + @right + @center) / 3.0
    # cy = @height / 3.0
    # [cx, cy]
  end

  def height=(new_height)
    @height = new_height
  end

  def larsen(ratio)
    t = self.dup
    t.height=(t.height * ratio)
    t
  end

  def mamdani(clip_height)
    left      = @left
    top_left  = @left + (clip_height * (@center - @left))
    top_right = @right - (clip_height * (@right - @center))
    right     = @right

    FuzzyAssociativeMemory::Trapezoid.new(left, top_left, top_right, right, clip_height)
  end

  def to_s
    "Triangle {#{@left}/#{@center}/#{@right}, height #{@height}}"
  end

end
