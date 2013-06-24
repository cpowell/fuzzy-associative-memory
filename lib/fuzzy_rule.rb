class FuzzyRule
  attr_reader :antecedent, :consequent

  def initialize(antecedent, consequent)
    @antecedent = antecedent
    @consequent = consequent
  end

  def calculate(value)
    input_dom = antecedent.dom(value)
    puts input_dom
  end
end
