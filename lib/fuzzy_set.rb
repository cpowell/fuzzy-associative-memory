class FuzzySet
  # The degree of membership in this set of a given value
  attr_accessor :dom

  # The maximum of the set's membership function.
  # for example, if the set is triangular then this will be the peak point of the triangle.
  # If the set has a plateau then this value will be the midpoint of the plateau.
  # This value is set in the constructor to avoid run-time calculation of midpoint values.
  attr_reader :representative_value

  # Return the Degree Of Membership in this set for the given value.
  #
  # * *Args*    :
  #   - +value+ -> the value in question
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  def calculate_dom(value)
    raise "Subclass must define!"
  end

  def or_with_dom(value)
    raise "Subclass must define!"
  end

  def clear_dom
    @dom = 0.0
  end

end
