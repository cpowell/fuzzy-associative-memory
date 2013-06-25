# encoding: utf-8
class FuzzyRuleset
  attr_accessor :rules
  attr_reader :name

  def initialize(name)
    @name           = name
    @rules          = []
    @antecedent_mus = []
    @consequents    = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end

  def calculate(input_value)
    @rules.each_with_index do |rule, rule_num|
      # Fire each rule to determine the µ value (degree of fit) for the
      # antecedent fuzzy set.
      @antecedent_mus[rule_num] = rule.fire(input_value)

      # Using the antecedent's µ value, alter the consequent fuzzy set's
      # polgyon. This is called implication, and 'weights' the output sets to
      # map properly. There are several common ways of doing it, such as Larsen
      # (scaling) and Mamdani (clipping).
      @consequents[rule_num] = rule.consequent.larsen(@antecedent_mus[rule_num])
    end

    # Defuzzify into a discrete & usable value by adding up the weighted
    # consequents' contributions to the output. Again there are several ways
    # of doing it, such as computing the centroid of the combined 'mass', and
    # the 'mean of maximum' of the tallest set(s). Here we use the "Average
    # of Maxima" summation mechanism. MaxAv is defined as:
    # (∑ representative value * height) / (∑ height) for all output sets
    # where 'representative value' is shape-dependent.
    numerator_terms   = @consequents.map { |set| set.centroid[0] * set.height }
    denominator_terms = @consequents.map { |set| set.height }

    numerator_terms.inject{|sum,x| sum + x } / denominator_terms.inject{|sum,x| sum + x }
  end
end
