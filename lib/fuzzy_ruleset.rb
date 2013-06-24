class FuzzyRuleset
  attr_reader :rules
  attr_reader :name

  def initialize(name)
    @name      = name
    @rules     = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end
end
