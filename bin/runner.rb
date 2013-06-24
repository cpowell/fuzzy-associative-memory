#!/usr/bin/env ruby

$:.push File.expand_path('../../lib/', __FILE__)

require 'fuzzy_variable'
require 'triangle'
require 'left_shoulder'
require 'right_shoulder'

require 'fuzzy_rule'
require 'fuzzy_ruleset'

cold       = LeftShoulder.new(-1, 0, 50)
cool       = Triangle.new(0, 55, 65)
just_right = Triangle.new(60, 65, 70)
warm       = Triangle.new(65, 75, 85)
hot        = RightShoulder.new(80, 90, 100)

temperature_in = FuzzyVariable.new("Temperature In")
temperature_in.fuzzy_sets = [cold, cool, just_right, warm, hot]

stop   = LeftShoulder.new(-1, 0, 30)
slow   = Triangle.new(10, 30, 50)
medium = Triangle.new(40, 50, 60)
fast   = Triangle.new(50, 70, 90)
blast  = RightShoulder.new(70, 100, 110)

fan_speed = FuzzyVariable.new("Fan speed")
fan_speed.fuzzy_sets = [stop, slow, medium, fast, blast]

temperature_in.result_for(65)
temperature_in.result_for(64)
temperature_in.result_for(63)
temperature_in.result_for(62)
temperature_in.result_for(61)
temperature_in.result_for(60)

