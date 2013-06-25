# encoding: utf-8
class FuzzyRule
  attr_reader :antecedent, :consequent

  # Marries an input fuzzy set and an output fuzzy set in an if-then
  # arrangement, i.e. if (antecedent) then (consequent).
  #
  # * *Args*    :
  #   - +antecedent+ -> the input fuzzy set
  #   - +consequent+ -> the output fuzzy set
  #
  def initialize(antecedent, consequent, natural_language=nil)
    @antecedent = antecedent
    @consequent = consequent
    @natural_language = natural_language
  end

  # Triggers the rule. The antecedent is fired with the supplied value
  # and the consequent is scaled according to the antecedent's DOM
  # (degree of membership).
  #
  # * *Args*    :
  #   - +value+ -> the input value for the rule (degrees, distance, strength, whatever)
  # * *Returns* :
  #   - the consequent, scaled by the antecedent's DOM
  # * *Raises* :
  #   - ++ ->
  #
  def fire(value)
    mu = antecedent.mu(value)
    # puts "Fired rule '#{@natural_language}': µ is #{mu}"
    mu
  end

end
