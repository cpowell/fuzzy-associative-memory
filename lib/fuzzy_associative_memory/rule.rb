# encoding: utf-8
#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
class FuzzyAssociativeMemory::Rule
  attr_reader :antecedents, :consequent, :boolean

  # Marries an input fuzzy set and an output fuzzy set in an if-then
  # arrangement, i.e. if (antecedent) then (consequent).
  #
  # * *Args*    :
  #   - +antecedent_array+ -> an array of one or more input fuzzy sets
  #   - +boolean+ -> term to join the antecedents, may be: nil, 'AND', 'OR'
  #   - +consequent+ -> the output fuzzy set
  #   - +natural_language+ -> a rule description (your own words), useful in output
  #
  def initialize(antecedent_array, boolean, consequent, natural_language=nil)
    if antecedent_array.is_a? String
      raise ArgumentError, "As of v1.0.1, Rule::initialize() has changed. Please see the code and CHANGELOG. (Sorry for the trouble.)"
    end

    raise ArgumentError, "Antecedent array must contain at least one fuzzy set" unless antecedent_array.size > 0
    raise ArgumentError, "Consequent must be provided" unless consequent

    if antecedent_array.size > 1
      raise ArgumentError, "boolean must be sym :and or :or" unless [:and, :or].include? boolean
    else
      raise ArgumentError, "boolean must be nil" unless boolean.nil?
    end

    @natural_language = natural_language
    @antecedents      = antecedent_array
    @consequent       = consequent
    @boolean          = boolean
  end

  # Triggers the rule. The antecedent(s) is/are fired with the supplied inputs
  # and the µ (degree of fit) is calculated and returned.
  #
  # * *Args*    :
  #   - +value_array+ -> an array of input values for the rule (degrees, distance, strength, whatever)
  # * *Returns* :
  #   - the degree of fit for this rule
  #
  def fire(value_array)
    mus = Array.new

    @antecedents.each_with_index do |antecedent, index|
      mus[index] = antecedent.mu(value_array[index])
    end

    if @boolean==:and
      mu = mus.min # AND / Intersection == minimum
    else
      mu = mus.max # OR / Union == maximum
    end

    puts "Fired rule '#{@natural_language}': µ choices are [#{mus.join(',')}], final µ is #{mu}" if $verbosity
    [@consequent, mu]
  end

end
