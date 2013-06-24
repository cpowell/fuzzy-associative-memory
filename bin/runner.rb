$:.push File.expand_path('../../lib/', __FILE__)

temperature_in = FuzzyRuleset.new("Temperature In")
temperature_in.add_rule LeftShoulder.new(-1, 0, 50)
temperature_in.add_rule Triangle.new(0, 55, 65)
temperature_in.add_rule Triangle.new(60, 65, 70)
temperature_in.add_rule Triangle.new(65, 75, 85)
temperature_in.add_rule RightShoulder.new(80, 90, 100)

