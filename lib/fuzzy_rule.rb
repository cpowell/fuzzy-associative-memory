class FuzzyRule
  attr_reader :antecedent, :consequent

  def initialize(antecedent, consequent)
    @antecedent = antecedent
    @consequent = consequent
  end

  def fire(value)
    input_dom = antecedent.dom(value)

    input_dom
  end
end
