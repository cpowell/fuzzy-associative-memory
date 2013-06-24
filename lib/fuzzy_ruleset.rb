class FuzzyRuleset
  attr_accessor :rules
  attr_reader :name

  def initialize(name)
    @name      = name
    @rules     = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end

  def calculate(value)
    @rules.each do |rule|
      rule.calculate(value)
    end
  end
end
