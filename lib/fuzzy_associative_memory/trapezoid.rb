#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
require 'fuzzy_associative_memory/set'
class FuzzyAssociativeMemory::Trapezoid < FuzzyAssociativeMemory::FuzzySet

  attr_reader :left, :top_left, :top_right, :right, :height

  def initialize(left, top_left, top_right, right, height=1.0)
    # TODO validations

    @left      = left.to_f
    @top_left  = top_left.to_f
    @top_right = top_right.to_f
    @right     = right.to_f
    @height    = height.to_f
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

  def centroid_x
    a = @top_right - @top_left
    b = @right - @left
    c = @top_left - @left

    cx = (2.0*a*c + a**2 + c*b + a*b + b**2.0) / (3.0 * (a+b))
    cx + @left
    # cy = (@height * (2.0*a + b)) / (3.0 * (a+b))
    # [cx+@left, cy]
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
    top_left  = @left + (clip_height * (@top_left - @left))
    top_right = @right - (clip_height * (@right - @top_right))
    right     = @right

    FuzzyAssociativeMemory::Trapezoid.new(left, top_left, top_right, right, clip_height)
  end

  def to_s
    "Trapezoid {#{@left}/#{@top_left}/#{@top_right}/#{@right}, height #{@height}}"
  end

end
