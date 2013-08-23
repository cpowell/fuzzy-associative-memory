#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
class FuzzyAssociativeMemory::FuzzySet

  # mu (named for the symbol) is the 'membership function', sometimes known as
  # the 'degree of fit' or the 'degree of membership'. This computed value
  # informs HOW MUCH this set activates or fires for the provided input value.
  # A DoM of zero means that this set fits the input not at all; a DoM of 1.0
  # means that this set fires / fits completely.
  #
  # * *Args*    :
  #   - +value+ -> the input value in question
  # * *Returns* :
  #   - a 'fitness' degree between 0 and 1.0
  #
  def mu(value)
    raise "Subclass must define!"
  end

  def centroid_x
    raise "Subclass must define!"
  end

  def larsen(ratio)
    raise "Subclass must define!"
  end

  def mamdani(ratio)
    raise "Subclass must define!"
  end

end
