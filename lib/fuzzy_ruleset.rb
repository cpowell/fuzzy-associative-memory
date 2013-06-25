# encoding: utf-8
class FuzzyRuleset
  attr_accessor :rules
  attr_reader :name

  def initialize(name)
    @name        = name
    @rules       = []
    @consequents = []
    @input_mus   = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end

  def calculate(value)
    # Fire each rule to determine the µ value (degree of fit) for the
    # antecedent fuzzy set.
    @rules.each_with_index do |rule, index|
      @input_mus[index] = rule.fire(value)
    end

    # Using the antecedent's µ value, scale the consequent fuzzy set's
    # polgyon. This is called implication, and 'weights' the output sets to
    # map properly. There are several common ways of doing it, such as Larsen
    # (scaling) and Mamdani (clipping).
    @rules.each_with_index do |rule, index|
      @consequents[index] = rule.consequent.larsen(@input_mus[index])
    end

    # Defuzzify into a discrete & usable value. Here we use the "Average of
    # Maxima" mechanism. MaxAv is defined as:
    # (Sigma representative value * µ) / (Sigma µ) for all output sets
    outputs = @consequents.map { |set| set.centroid[0] * set.height }
    heights = @consequents.map { |set| set.height }

    outputs.inject{|sum,x| sum + x } / heights.inject{|sum,x| sum + x }
  end
end
