#!/usr/bin/env ruby

$:.push File.expand_path('../../lib/', __FILE__)
require 'fuzzy_ruleset'
require 'triangle'
require 'left_shoulder'
require 'right_shoulder'

temperature_in = FuzzyRuleset.new("Temperature In")
temperature_in.add_rule LeftShoulder.new(-1, 0, 50)
temperature_in.add_rule Triangle.new(0, 55, 65)
temperature_in.add_rule Triangle.new(60, 65, 70)
temperature_in.add_rule Triangle.new(65, 75, 85)
temperature_in.add_rule RightShoulder.new(80, 90, 100)

temperature_in.result_for(65)
temperature_in.result_for(64)
temperature_in.result_for(63)
temperature_in.result_for(62)
temperature_in.result_for(61)
temperature_in.result_for(60)

