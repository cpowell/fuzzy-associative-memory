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

  def shrink_to(ratio)
    raise "Subclass must define!"
  end
end
