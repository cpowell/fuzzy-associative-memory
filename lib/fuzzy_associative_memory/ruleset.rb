# encoding: utf-8
#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
class FuzzyAssociativeMemory::Ruleset
  attr_accessor :rules
  attr_reader :name
  attr_reader :implication

  def initialize(name, implication_mechanism)
    raise ArgumentError, 'invalid implication mechanism' unless [:larsen, :mamdani].include? implication_mechanism
    @name  = name
    @rules = []
    @implication = implication_mechanism
  end

  def add_rule(rule)
    @rules << rule
  end

  def calculate(*input_values)
    @consequent_mus   = {}
    @consequents      = []

    puts ">>> Firing all rules..." if $verbosity
    @rules.each_with_index do |rule, rule_num|
      # Fire each rule to determine the µ value (degree of fit).
      # Gather the µ vals by consequent, since each consequent may in fact
      # have been fired more than once and we'll need that knowledge in a
      # moment...
      cons, mu = rule.fire(input_values)

      # Since any given consequent may have been activated more than once, we
      # need to get just a single µ value out -- we only care about the 'best'
      # µ. A popular way of doing so is to OR the values together, i.e. keep the
      # maximum µ value and discard the others.
      if @consequent_mus.has_key?(cons)
        if mu > @consequent_mus[cons]
          @consequent_mus[cons] = mu
      else
        @consequent_mus[cons] = mu
      end
    end

    # Using each µ value, alter the consequent fuzzy set's polgyon. This is
    # called implication, and 'weights' the consequents properly. There are
    # several common ways of doing it, such as Larsen (scaling) and Mamdani
    # (clipping).
    @consequent_mus.each do |cons, mu|
      case @implication
      when :mamdani
        @consequents << cons.mamdani(mu)
      when :larsen
        @consequents << cons.larsen(mu)
      else
        raise RuntimeError, "I must have been passed an unknown implication mechanism: #{@implication}"
      end
    end

    # Defuzzify into a discrete & usable value by adding up the weighted
    # consequents' contributions to the output. Again there are several ways
    # of doing it, such as computing the centroid of the combined 'mass', or
    # the 'mean of maximum' of the tallest set(s). Here we use the "Average
    # of Maxima" summation mechanism. MaxAv is defined as:
    # (∑ representative value * height) / (∑ height) for all output sets
    # where 'representative value' is shape-dependent.
    numerator=0
    denominator=0

    @consequents each do |cons|
      numerator += cons.centroid_x * cons.height
      denominator += cons.height
    end

    return numerator/denominator

    # numerator_terms   = @consequents.map { |set| set.centroid_x * set.height }
    # denominator_terms = @consequents.map { |set| set.height }
    # numerator_terms.inject{|sum,x| sum + x } / denominator_terms.inject{|sum,x| sum + x }
  end
end
