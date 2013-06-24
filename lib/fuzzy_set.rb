class FuzzySet

  # The DoM is the 'degree of membership'. Also known as the 'degree of fit',
  # this computed value informs HOW MUCH this set activates or fires for the
  # provided input value. A DoM of zero means that this set fits the input not
  # at all; a DoM of 1.0 means that this set fires / fits completely.
  #
  # * *Args*    :
  #   - +value+ -> the input value in question
  # * *Returns* :
  #   - a 'fitness' degree between 0 and 1.0
  #
  def calculate_dom(value)
    raise "Subclass must define!"
  end

  def scale(ratio)
    raise "Subclass must define!"
  end

  def centroid
    raise "Subclass must define!"
  end
end
