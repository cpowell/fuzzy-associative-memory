class FuzzyRuleset

  attr_reader @rules
  attr_reader @min_range
  attr_reader @max_range
  attr_reader @name

  def initialize(name)
    @name=name
    @rules = []
    @min_range=0
    @max_range=0
  end

  def add_rule(fuzzy_set)
    @rules << fuzzy_set
  end


end
