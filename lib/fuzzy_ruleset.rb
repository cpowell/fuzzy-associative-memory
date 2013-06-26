# encoding: utf-8
require 'pp'

class FuzzyRuleset
  attr_accessor :rules
  attr_reader :name

  def initialize(name)
    @name  = name
    @rules = []
  end

  def add_rule(fuzzy_rule)
    @rules << fuzzy_rule
  end

  def calculate(*input_values)
    @consequents    = []
    @kept_consequents = Hash.new
    @consequent_mus = Hash.new

    puts ">>> Firing all rules..."
    @rules.each_with_index do |rule, rule_num|
      # Fire each rule to determine the µ value (degree of fit).
      # Gather the µ vals by consequent, since each consequent may in fact
      # have been fired more than once.
      cons, mu = rule.fire(input_values)
      if @consequent_mus.has_key?(cons)
        @consequent_mus[cons] << mu
      else
        @consequent_mus[cons] = [mu]
      end
    end

    # Since any given consequent may have fired more than once, we need
    # to get just a single µ value out of each one. A popular way of doing
    # so is to OR the values together, i.e. take the maximum µ value.
    @consequent_mus.each do |cons, mu_array|
      @kept_consequents[cons] = mu_array.max
    end

    # Using each µ value, alter the consequent fuzzy set's polgyon. This is
    # called implication, and 'weights' the output sets to map properly. There
    # are several common ways of doing it, such as Larsen (scaling) and
    # Mamdani (clipping).
    @kept_consequents.each do |cons, mu|
      @consequents << cons.larsen(mu)
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
