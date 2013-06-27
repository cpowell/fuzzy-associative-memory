#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
class FuzzyAssociativeMemory::FuzzyLinguisticVariable
  attr_accessor :fuzzy_sets
  attr_reader :name

  def initialize(name)
    @name       = name
    @fuzzy_sets = []
  end

  def add_set(fuzzy_set)
    @fuzzy_sets << fuzzy_set
  end

  def [](n)
    @fuzzy_sets[n]
  end
end
