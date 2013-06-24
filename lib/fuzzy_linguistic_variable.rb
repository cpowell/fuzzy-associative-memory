class FuzzyLinguisticVariable

  attr_reader @member_sets
  attr_reader @min_range
  attr_reader @max_range
  attr_reader @name

  def initialize(name)
    @name=name
    @member_sets = []
    @min_range=0
    @max_range=0
  end

  def add_set(fuzzy_set)
    @member_sets << fuzzy_set
  end


end
