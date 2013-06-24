$:.push File.expand_path('../../lib/', __FILE__)

flv = FuzzyLinguisticVariable.new("Distance To Target")
flv.add_set LeftShoulder.new(25, 25, 125)
flv.add_set Triangle.new(150, 125, 150)
flv.add_set Triangle.new(300, 150, 200)

