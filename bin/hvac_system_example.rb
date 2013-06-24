#!/usr/bin/env ruby

$:.push File.expand_path('../../lib/', __FILE__)

require 'fuzzy_variable'
require 'triangle'
require 'left_shoulder'
require 'right_shoulder'

require 'fuzzy_rule'
require 'fuzzy_ruleset'

# This example is the logic to drive an HVAC fan unit depending on the ambient
# room temperature. A hotter room needs a higher fan; in a cooler room the fan
# can slow, and in a cold room the fan should stop. For the graphs and
# explanation of this particular FAM, see "Fuzzy Thinking" by Bart Kosko:
# http://www.amazon.com/Fuzzy-Thinking-New-Science-Logic/dp/1562828398/

# The input side -- the antecedent -- is expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'temperature
# input' variable, is the  assemblage of all our fuzzy input sets.
temperature_in = FuzzyVariable.new("room temperature") # degrees fahrenheit

# Wider: less important, coarse control; narrower: more important, fine control
cold       = Triangle.new(30, 40, 50)  # 20 deg wide
cool       = Triangle.new(45, 55, 65)  # 20 deg wide
just_right = Triangle.new(60, 65, 70)  # 10 deg wide
warm       = Triangle.new(65, 75, 85)  # 20 deg wide
hot        = Triangle.new(80, 90, 100) # 20 deg wide

temperature_in.fuzzy_sets = [cold, cool, just_right, warm, hot]

# The output side -- the consequent -- expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'resultant
# fan speed' variable, is the  assemblage of all our fuzzy output sets.
fan_speed = FuzzyVariable.new("fan speed") # cubic feet per minute (CFM)

stop   = Triangle.new(-30, 0, 30)   # 60 CFM wide
slow   = Triangle.new(10, 30, 50)   # 40 CFM wide
medium = Triangle.new(40, 50, 60)   # 20 CFM wide
fast   = Triangle.new(50, 70, 90)   # 40 CFM wide
blast  = Triangle.new(70, 100, 130) # 60 CFM wide

fan_speed.fuzzy_sets = [stop, slow, medium, fast, blast]

# Natural-language marriage of the inputs to the outputs, e.g.
# "If the temperature is cool, the fan motor speed should be slow."
system = FuzzyRuleset.new("HVAC control")

rule_1 = FuzzyRule.new(temperature_in[0], fan_speed[0])
rule_2 = FuzzyRule.new(temperature_in[1], fan_speed[1])
rule_3 = FuzzyRule.new(temperature_in[2], fan_speed[2])
rule_4 = FuzzyRule.new(temperature_in[3], fan_speed[3])
rule_5 = FuzzyRule.new(temperature_in[4], fan_speed[4])

system.rules = [rule_1, rule_2, rule_3, rule_4, rule_5]

# Check the logic for a wide range of temps and output the results
(40..90).each do |n|
  puts "The #{system.name} determines: for #{temperature_in.name} #{n}, the #{fan_speed.name} is #{system.calculate(n)} CFM"
end
