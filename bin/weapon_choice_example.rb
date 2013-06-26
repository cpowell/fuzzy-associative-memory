#!/usr/bin/env ruby
$:.push File.expand_path('../../lib/', __FILE__)

require 'fuzzy_variable'
require 'triangle'
require 'trapezoid'

require 'fuzzy_rule'
require 'fuzzy_ruleset'

# This example is inspired by the fuzzy logic described by Mat Buckland in
# "Programming Game AI by Example". In this we illustrate how an AI 'bot'
# might use fuzzy logic to pick which weapon to use. Unlike the 'HVAC system'
# example, which uses just one input, this example uses two inputs: distance
# to enemy, and ammo remaining. Using these two variables the bot can decide
# the suitability or desirability of a given weapon.

# The input side -- the antecedents -- are expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'distance to
# target' variable is an assemblage of our fuzzy input sets.
target_dist = FuzzyVariable.new("distance to target") # pixels

tgt_close  = Trapezoid.new(-150, -25, 25, 150)
tgt_medium = Triangle.new(25, 150, 300)
tgt_far    = Trapezoid.new(150, 300, 500, 650)

target_dist.fuzzy_sets = [tgt_close, tgt_medium, tgt_far]

# Now for the second input (or antecedent): the amount of ammo left for this
# particular weapon.
rocket_ammo_status = FuzzyVariable.new("rocket launcher ammo quantity")

rkt_ammo_low   = Triangle.new(-10, 0, 10)
rkt_ammo_okay  = Triangle.new(0, 10, 30)
rkt_ammo_loads = Trapezoid.new(10, 30, 50, 70)

rocket_ammo_status.fuzzy_sets = [rkt_ammo_low, rkt_ammo_okay, rkt_ammo_loads]

# The output side -- the consequent -- expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'resultant
# fan speed' variable is the  assemblage of all our fuzzy output sets.
desirability = FuzzyVariable.new("rocket launcher desirability")

undes   = Trapezoid.new(0, 0, 20, 50)
desir   = Triangle.new(30, 50, 70)
v_desir = Trapezoid.new(50, 80, 100, 100)

desirability.fuzzy_sets = [undes, desir, v_desir]

# Natural-language marriage of the inputs to the outputs, e.g.
# "If the temperature is cool, the fan motor speed should be slow."
system = FuzzyRuleset.new("Rocket launcher desirability as a weapon")

rule_1 = FuzzyRule.new('If target is far and I have loads of rocket ammo, rocket launcher is desirable', [tgt_far, rkt_ammo_loads], :and, desir)
rule_2 = FuzzyRule.new('If target is far and I have some rocket ammo, rocket launcher is undesirable', [tgt_far, rkt_ammo_okay], :and, undes)
rule_3 = FuzzyRule.new('If target is far and I have low rocket ammo, rocket launcher is undesirable', [tgt_far, rkt_ammo_low], :and, undes)
rule_4 = FuzzyRule.new('If target is medium-distance and I have loads of rocket ammo, rocket launcher is very desirable', [tgt_medium, rkt_ammo_loads], :and, v_desir)
rule_5 = FuzzyRule.new('If target is medium-distance and I have some rocket ammo, rocket launcher is very desirable', [tgt_medium, rkt_ammo_okay], :and, v_desir)
rule_6 = FuzzyRule.new('If target is medium-distance and I have low rocket ammo, rocket launcher is desirable', [tgt_medium, rkt_ammo_low], :and, desir)
rule_7 = FuzzyRule.new('If target is close and I have loads of rocket ammo, rocket launcher is undesirable', [tgt_close, rkt_ammo_loads], :and, undes)
rule_8 = FuzzyRule.new('If target is close and I have some rocket ammo, rocket launcher is undesirable', [tgt_close, rkt_ammo_okay], :and, undes)
rule_9 = FuzzyRule.new('If target is close and I have low rocket ammo, rocket launcher is undesirable', [tgt_close, rkt_ammo_low], :and, undes)

system.rules = [rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7, rule_8, rule_9]

d = 200
a = 8
puts "#{system.name}: for #{target_dist.name} #{d} and #{rocket_ammo_status.name} #{a}, the #{desirability.name} is #{system.calculate(200, 8)}"
