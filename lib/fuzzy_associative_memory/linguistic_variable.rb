#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
class FuzzyAssociativeMemory::LinguisticVariable
  attr_accessor :sets
  attr_reader :name

  def initialize(name)
    @name       = name
    @sets = []
  end

  def add_set(set)
    @sets << set
  end

  def [](n)
    @sets[n]
  end
end
