#!/usr/bin/env ruby
#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
require 'fuzzy_associative_memory'

# Set me to true to enable some verbose output of my calculations...
$verbosity = false

# This example is the logic to drive an HVAC fan unit depending on the ambient
# room temperature. A hotter room needs a higher fan; in a cooler room the fan
# can slow, and in a cold room the fan should stop. For the graphs and
# explanation of this particular FAM, see "Fuzzy Thinking" by Bart Kosko:
# http://www.amazon.com/Fuzzy-Thinking-New-Science-Logic/dp/1562828398/

# The input side -- the antecedent -- is expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'temperature
# input' variable, is the  assemblage of all our fuzzy input sets.
temperature_in = FuzzyAssociativeMemory::LinguisticVariable.new("room temperature") # degrees fahrenheit

# Wider: less important, coarse control; narrower: more important, fine control
cold       = FuzzyAssociativeMemory::Trapezoid.new(40, 40, 40, 50)  # 20 deg wide
cool       = FuzzyAssociativeMemory::Triangle.new(45, 55, 65)  # 20 deg wide
just_right = FuzzyAssociativeMemory::Triangle.new(60, 65, 70)  # 10 deg wide
warm       = FuzzyAssociativeMemory::Triangle.new(65, 75, 85)  # 20 deg wide
hot        = FuzzyAssociativeMemory::Trapezoid.new(80, 90, 90, 90) # 20 deg wide

temperature_in.sets = [cold, cool, just_right, warm, hot]
# Comment out if you don't have Gnuplot installed:
temperature_in.gnuplot

# The output side -- the consequent -- expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'resultant
# fan speed' variable, is the  assemblage of all our fuzzy output sets.
fan_speed = FuzzyAssociativeMemory::LinguisticVariable.new("fan speed") # cubic feet per minute (CFM)

stop   = FuzzyAssociativeMemory::Triangle.new(-30, 0, 30)   # 60 CFM wide
slow   = FuzzyAssociativeMemory::Triangle.new(10, 30, 50)   # 40 CFM wide
medium = FuzzyAssociativeMemory::Triangle.new(40, 50, 60)   # 20 CFM wide
fast   = FuzzyAssociativeMemory::Triangle.new(50, 70, 90)   # 40 CFM wide
blast  = FuzzyAssociativeMemory::Triangle.new(70, 100, 130) # 60 CFM wide

fan_speed.sets = [stop, slow, medium, fast, blast]
# Comment out if you don't have Gnuplot installed:
fan_speed.gnuplot

# Natural-language marriage of the inputs to the outputs, e.g.
# "If the temperature is cool, the fan motor speed should be slow."
system = FuzzyAssociativeMemory::Ruleset.new("HVAC control", :larsen)

rule_1 = FuzzyAssociativeMemory::Rule.new([cold],       nil, stop   , 'If room is cold, the fan motor stops' )
rule_2 = FuzzyAssociativeMemory::Rule.new([cool],       nil, slow   , 'If room is cool, the fan motor is slow' )
rule_3 = FuzzyAssociativeMemory::Rule.new([just_right], nil, medium , 'If room is just right, the fan motor is medium' )
rule_4 = FuzzyAssociativeMemory::Rule.new([warm],       nil, fast   , 'If room is warm, the fan motor speeds up' )
rule_5 = FuzzyAssociativeMemory::Rule.new([hot],        nil, blast  , 'If room is hot, the fan motor runs full-blast' )

system.rules = [rule_1, rule_2, rule_3, rule_4, rule_5]

# n=64
# puts "The #{system.name} determines: for #{temperature_in.name} #{n}, the #{fan_speed.name} is #{system.calculate(n)} CFM"

# Check the logic for a wide range of temps and output the results
(40..90).each do |n|
  puts "The #{system.name} determines: for #{temperature_in.name} #{n}, the #{fan_speed.name} is #{system.calculate(n)} CFM"
end
