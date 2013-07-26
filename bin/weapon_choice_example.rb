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

implication = :mamdani # or :larsen

# This is a complicated example; I recommend you understand the 'HVAC system
# example' before trying to grok this one.
#
# This example is inspired by the fuzzy logic described by Mat Buckland in
# "Programming Game AI by Example". In this we illustrate how an AI 'bot'
# might use fuzzy logic to pick which weapon to use. Unlike the 'HVAC system'
# example, which uses just one input, this example uses two inputs: distance
# to enemy, and ammo remaining. WE SET UP AND RUN TWO FAMS, FOR TWO DIFFERENT
# WEAPONS (ROCKET AND SHOTGUN), TO CHOOSE WHICH WEAPON TO USE.

# The input side -- the antecedents -- are expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'distance to
# target' variable is an assemblage of our fuzzy input sets.
target_dist = FuzzyAssociativeMemory::LinguisticVariable.new("distance to target") # pixels

tgt_close  = FuzzyAssociativeMemory::Trapezoid.new(-150, -25, 25, 150)
tgt_medium = FuzzyAssociativeMemory::Triangle.new(25, 150, 300)
tgt_far    = FuzzyAssociativeMemory::Trapezoid.new(150, 300, 500, 650)

target_dist.sets = [tgt_close, tgt_medium, tgt_far]
# Comment out if you don't have Gnuplot installed:
target_dist.gnuplot

# Now for the second input (or antecedent): the amount of ammo left for this
# particular weapon.
rocket_ammo_status = FuzzyAssociativeMemory::LinguisticVariable.new("rocket launcher ammo quantity")

rkt_ammo_low   = FuzzyAssociativeMemory::Triangle.new(-10, 0, 10)
rkt_ammo_okay  = FuzzyAssociativeMemory::Triangle.new(0, 10, 30)
rkt_ammo_loads = FuzzyAssociativeMemory::Trapezoid.new(10, 30, 40, 40)

rocket_ammo_status.sets = [rkt_ammo_low, rkt_ammo_okay, rkt_ammo_loads]
# Comment out if you don't have Gnuplot installed:
rocket_ammo_status.gnuplot

# The output side -- the consequent -- expressed as a number of fuzzy sets,
# with each set representing a natural-language description. The 'resultant
# fan speed' variable is the  assemblage of all our fuzzy output sets.
desirability = FuzzyAssociativeMemory::LinguisticVariable.new("weapon desirability")

undesirable    = FuzzyAssociativeMemory::Trapezoid.new(0, 0, 20, 50)
desirable      = FuzzyAssociativeMemory::Triangle.new(30, 50, 70)
very_desirable = FuzzyAssociativeMemory::Trapezoid.new(50, 80, 100, 100)

desirability.sets = [undesirable, desirable, very_desirable]
# Comment out if you don't have Gnuplot installed:
desirability.gnuplot

# Natural-language marriage of the inputs to the outputs, e.g.
# "If the temperature is cool, the fan motor speed should be slow."
rkt_ruleset = FuzzyAssociativeMemory::Ruleset.new("Rocket launcher desirability", implication)

rule_1 = FuzzyAssociativeMemory::Rule.new([tgt_far, rkt_ammo_loads], :and, desirable, 'If target is far and I have loads of rocket ammo, rocket launcher is desirable')
rule_2 = FuzzyAssociativeMemory::Rule.new([tgt_far, rkt_ammo_okay], :and, undesirable, 'If target is far and I have some rocket ammo, rocket launcher is undesirable')
rule_3 = FuzzyAssociativeMemory::Rule.new([tgt_far, rkt_ammo_low], :and, undesirable, 'If target is far and I have low rocket ammo, rocket launcher is undesirable')
rule_4 = FuzzyAssociativeMemory::Rule.new([tgt_medium, rkt_ammo_loads], :and, very_desirable, 'If target is medium-distance and I have loads of rocket ammo, rocket launcher is very desirable')
rule_5 = FuzzyAssociativeMemory::Rule.new([tgt_medium, rkt_ammo_okay], :and, very_desirable, 'If target is medium-distance and I have some rocket ammo, rocket launcher is very desirable')
rule_6 = FuzzyAssociativeMemory::Rule.new([tgt_medium, rkt_ammo_low], :and, desirable, 'If target is medium-distance and I have low rocket ammo, rocket launcher is desirable')
rule_7 = FuzzyAssociativeMemory::Rule.new([tgt_close, rkt_ammo_loads], :and, undesirable, 'If target is close and I have loads of rocket ammo, rocket launcher is undesirable')
rule_8 = FuzzyAssociativeMemory::Rule.new([tgt_close, rkt_ammo_okay], :and, undesirable, 'If target is close and I have some rocket ammo, rocket launcher is undesirable')
rule_9 = FuzzyAssociativeMemory::Rule.new([tgt_close, rkt_ammo_low], :and, undesirable, 'If target is close and I have low rocket ammo, rocket launcher is undesirable')

rkt_ruleset.rules = [rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7, rule_8, rule_9]

d  = 110
ra = 8
rocket_desirability = rkt_ruleset.calculate(d, ra)
puts "#{rkt_ruleset.name}: for #{target_dist.name} #{d} and #{rocket_ammo_status.name} #{ra}, the #{desirability.name} is #{rocket_desirability}"

##################################
# That was ONE FAM. Now we set up a WHOLE NEW FAM based on the shotgun data.
# We can re-use the 'desirability' consequent since that's static across all
# weapons. We just need new antecedents and rules.

# Now for the second input (or antecedent): the amount of ammo left for this
# particular weapon.
shotgun_ammo_status = FuzzyAssociativeMemory::LinguisticVariable.new("shotgun ammo quantity")
gun_ammo_low   = FuzzyAssociativeMemory::Triangle.new(-10, 0, 10)
gun_ammo_okay  = FuzzyAssociativeMemory::Triangle.new(0, 10, 30)
gun_ammo_loads = FuzzyAssociativeMemory::Trapezoid.new(10, 30, 40, 40)
shotgun_ammo_status.sets = [gun_ammo_low, gun_ammo_okay, gun_ammo_loads]

gun_ruleset = FuzzyAssociativeMemory::Ruleset.new("Shotgun desirability", implication)
rule_1 = FuzzyAssociativeMemory::Rule.new([tgt_far, gun_ammo_loads], :and, undesirable, 'If target is far and I have loads of shotgun ammo, shotgun is undesirable')
rule_2 = FuzzyAssociativeMemory::Rule.new([tgt_far, gun_ammo_okay], :and, undesirable, 'If target is far and I have some shotgun ammo, shotgun is undesirable')
rule_3 = FuzzyAssociativeMemory::Rule.new([tgt_far, gun_ammo_low], :and, undesirable, 'If target is far and I have low shotgun ammo, shotgun is undesirable')
rule_4 = FuzzyAssociativeMemory::Rule.new([tgt_medium, gun_ammo_loads], :and, desirable, 'If target is medium-distance and I have loads of shotgun ammo, shotgun is desirable')
rule_5 = FuzzyAssociativeMemory::Rule.new([tgt_medium, gun_ammo_okay], :and, desirable, 'If target is medium-distance and I have some shotgun ammo, shotgun is desirable')
rule_6 = FuzzyAssociativeMemory::Rule.new([tgt_medium, gun_ammo_low], :and, undesirable, 'If target is medium-distance and I have low shotgun ammo, shotgun is undesirable')
rule_7 = FuzzyAssociativeMemory::Rule.new([tgt_close, gun_ammo_loads], :and, very_desirable, 'If target is close and I have loads of shotgun ammo, shotgun is very desirable')
rule_8 = FuzzyAssociativeMemory::Rule.new([tgt_close, gun_ammo_okay], :and, very_desirable, 'If target is close and I have some shotgun ammo, shotgun is very desirable')
rule_9 = FuzzyAssociativeMemory::Rule.new([tgt_close, gun_ammo_low], :and, very_desirable, 'If target is close and I have low shotgun ammo, shotgun is very desirable')
gun_ruleset.rules = [rule_1, rule_2, rule_3, rule_4, rule_5, rule_6, rule_7, rule_8, rule_9]

sa = 12
gun_desirability = gun_ruleset.calculate(d, sa)
puts "#{gun_ruleset.name}: for #{target_dist.name} #{d} and #{shotgun_ammo_status.name} #{sa}, the #{desirability.name} is #{gun_desirability}"

if gun_desirability < rocket_desirability
  outcome='I choose the rocket launcher.'
else
  outcome='I choose the shotgun.'
end

puts outcome
