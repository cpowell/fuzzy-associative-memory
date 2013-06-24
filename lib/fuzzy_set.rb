class FuzzySet
  # Return the Degree Of Membership in this set for the given value.
  #
  # * *Args*    :
  #   - +value+ -> the value in question
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  def dom(value)
    raise "Subclass must define!"
  end

  def scale(ratio)
    raise "Subclass must define!"
  end

  def centroid
    raise "Subclass must define!"
  end
end
