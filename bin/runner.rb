#!/usr/bin/env ruby

$:.push File.expand_path('../../lib/', __FILE__)

require 'fuzzy_variable'
require 'triangle'
require 'left_shoulder'
require 'right_shoulder'

require 'fuzzy_rule'
require 'fuzzy_ruleset'

# Our input expressed as a number of fuzzy sets, with each set
# representing a natural-language description
cold       = Triangle.new(-50, 0, 50)
cool       = Triangle.new(0, 55, 65)
just_right = Triangle.new(60, 65, 70)
warm       = Triangle.new(65, 75, 85)
hot        = Triangle.new(80, 90, 100)

# Our 'temperature input' variable, which is the assemblage of
# all our fuzzy input sets
temperature_in = FuzzyVariable.new("Temperature In")
temperature_in.fuzzy_sets = [cold, cool, just_right, warm, hot]

# Our output expressed as a number of fuzzy sets, with each set
# representing a natural-language description
stop   = Triangle.new(-30, 0, 30)
slow   = Triangle.new(10, 30, 50)
medium = Triangle.new(40, 50, 60)
fast   = Triangle.new(50, 70, 90)
blast  = Triangle.new(70, 100, 130)

# Our 'resultant fan speed' variable, which is the assemblage of
# all our fuzzy output sets
fan_speed = FuzzyVariable.new("Fan speed")
fan_speed.fuzzy_sets = [stop, slow, medium, fast, blast]

# Natural-language marriage of the inputs to the outputs, e.g.
# "If the temperature is cool, the motor speed should be slow."
rule_1 = FuzzyRule.new(temperature_in[0], fan_speed[0])
rule_2 = FuzzyRule.new(temperature_in[1], fan_speed[1])
rule_3 = FuzzyRule.new(temperature_in[2], fan_speed[2])
rule_4 = FuzzyRule.new(temperature_in[3], fan_speed[3])
rule_5 = FuzzyRule.new(temperature_in[4], fan_speed[4])

system = FuzzyRuleset.new("HVAC control")
system.rules = [rule_1, rule_2, rule_3, rule_4, rule_5]
puts system.calculate(63)

# (60..70).each do |n|
#   puts system.calculate(n)
# end
