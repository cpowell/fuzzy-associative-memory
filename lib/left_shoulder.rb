#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
require 'lib/fuzzy_set'

class LeftShoulder < FuzzySet

  attr_reader :left, :peak, :right, :height

  def initialize(left, peak, right, height=1.0)
    # TODO validations

    @peak         = peak
    @left         = left
    @right        = right
    @height       = height
    @right_subdiv = -@height / (@peak - @right)
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

  def height=(new_height)
    @height       = new_height
    @right_subdiv = -@height / (@peak - @right)
  end

  def scale(percentage)
    t = self.dup
    t.height=(t.height * percentage)
    t
  end

  def to_s
    "LeftShoulder {#{left}/#{peak}/#{right}, height #{height}}"
  end
end
