class FuzzyRuleset
  attr_accessor :rules
  attr_reader :name

  def initialize(name)
    @name        = name
    @rules       = []
    @scaled_sets = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end

  def calculate(value)
    @rules.each_with_index do |rule, index|
      @scaled_sets[index] = rule.fire(value)
    end

    puts @scaled_sets.join(', ')
    x_centroids = @scaled_sets.map { |set| set.centroid[0] }
    outputs = @scaled_sets.map { |set| set.centroid[0] * set.height}

    outputs.inject{|sum,x| sum + x }
  end
end
