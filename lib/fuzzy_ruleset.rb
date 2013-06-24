class FuzzyRuleset
  attr_reader :rules
  attr_reader :name

  def initialize(name)
    @name      = name
    @rules     = []
  end

  def add_rule(fuzzy_set)
    @rules << fuzzy_set
  end

  def result_for(value)
    @doms = Array.new
    @rules.each do |rule|
      @doms << rule.dom(value)
    end

    puts @doms.join(", ")
  end


end
