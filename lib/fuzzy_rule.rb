class FuzzyRule
  attr_reader :antecedent, :consequent

  def initialize(antecedent, consequent)
    @antecedent = antecedent
    @consequent = consequent
  end
end
