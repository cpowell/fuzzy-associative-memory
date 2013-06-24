class FuzzyRuleset
  attr_accessor :rules
  attr_reader :name

  def initialize(name)
    @name  = name
    @rules = []
    @doms  = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end

  def calculate(value)
    @rules.each_with_index do |rule, index|
      @doms[index] = rule.fire(value)
    end

    puts @doms.join(', ')
  end
end
