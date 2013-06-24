class FuzzyVariable
  attr_accessor :fuzzy_sets
  attr_reader :name

  def initialize(name)
    @name       = name
    @fuzzy_sets = []
  end

  def add_set(fuzzy_set)
    @fuzzy_sets << fuzzy_set
  end

  def result_for(value)
    @doms = Array.new
    @fuzzy_sets.each do |set|
      @doms << set.dom(value)
    end

    puts @doms.join(", ")
  end


end
