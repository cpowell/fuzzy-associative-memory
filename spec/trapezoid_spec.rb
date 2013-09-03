require 'spec_helper'

describe "Trapezoid" do
  before :all do
    # per-context setup
  end

  before do
    # per-example setup
    @t = FuzzyAssociativeMemory::Trapezoid.new(7, 10, 13, 16)
  end

  after do
    # per-example teardown
  end

  after :all do
    # per-context teardown
  end

  it "has centroid where expected" do
    expect(@t.centroid_x).to eq(11.5)
  end

  it "has DOM 0 outside left bound" do
    expect(@t.mu(2)).to eq(0)
  end

  it "has DOM 0 outside right bound" do
    expect(@t.mu(17)).to eq(0)
  end

  it "has DOM 1 at peak" do
    expect(@t.mu(12)).to eq(1.0)
  end

  it "has DOM 1 at top left" do
    expect(@t.mu(10)).to eq(1.0)
  end

  it "has DOM 1 at top right" do
    expect(@t.mu(13)).to eq(1.0)
  end

  it "has DOM 0.5 at half right offset" do
    expect(@t.mu(14.5)).to eq(0.5)
  end

  it "has DOM 0.5 at half left offset" do
    expect(@t.mu(8.5)).to eq(0.5)
  end

  it "has DOM 0 at right" do
    expect(@t.mu(16)).to eq(0)
  end

  it "has DOM 0 at left" do
    expect(@t.mu(7)).to eq(0)
  end

  it "has correct DOM at 3/5 offset" do
    @t = FuzzyAssociativeMemory::Triangle.new(0, 5, 10)
    expect(@t.mu(3.0)).to eq(0.6)
  end

  it "has correct DOM at 7/10 offset" do
    @t = FuzzyAssociativeMemory::Triangle.new(0, 5, 10)
    expect(@t.mu(7.0)).to eq(0.6)
  end

  context "Centroid calculation" do
    it "has a proper centroid 1" do
      @t=FuzzyAssociativeMemory::Trapezoid.new(0, 20, 50, 50)
      expect(@t.centroid_x).to be_within(0.0005).of(29.583)
    end

    it "has a proper centroid 2" do
      @t=FuzzyAssociativeMemory::Trapezoid.new(0, 10, 20, 30)
      expect(@t.centroid_x).to eq(15)
    end

    it "has a proper centroid 3" do
      @t=FuzzyAssociativeMemory::Trapezoid.new(50, 80, 100, 100)
      expect(@t.centroid_x).to be_within(0.0005).of(81.4283)
    end
  end

  it "has the correct DOM when fully positive" do
    @t = FuzzyAssociativeMemory::Trapezoid.new(20, 30, 40, 50)
    expect(@t.mu(41)).to eq(0.9)
  end

  context "Larsen implication" do
    before do
      @scaled = @t.larsen(0.15)
    end

    it "stays a trapezoid" do
      expect(@scaled).to be_a(FuzzyAssociativeMemory::Trapezoid)
    end

    it "takes the height of the larsen value" do
      expect(@scaled.height).to eq(0.15)
    end

    it "keeps same corner points" do
      expect(@scaled.left).to eq(7)
      expect(@scaled.top_left).to eq(10)
      expect(@scaled.top_right).to eq(13)
      expect(@scaled.right).to eq(16)
    end
  end

  context "Mamdani implication" do
    before do
      @scaled = @t.mamdani(0.83)
    end

    it "stays a trapezoid" do
      expect(@scaled).to be_a(FuzzyAssociativeMemory::Trapezoid)
    end

    it "keeps same left and right corner points" do
      expect(@scaled.left).to eq(7)
      expect(@scaled.right).to eq(16)
    end

    it "takes the height of the mamdani value" do
      expect(@scaled.height).to eq(0.83)
    end
  end

  context "Mamdani with one point at zero" do
    before do
      @t = FuzzyAssociativeMemory::Trapezoid.new(0, 30, 100, 110)
      @scaled = @t.mamdani(0.83)
    end

    it "stays a trapezoid" do
      expect(@scaled).to be_a(FuzzyAssociativeMemory::Trapezoid)
    end

    it "keeps same left and right corner points" do
      expect(@scaled.left).to eq(0)
      expect(@scaled.right).to eq(110)
    end

    it "gets the correct new top left" do
      expect(@scaled.top_left).to eq(24.9)
    end

    it "gets the correct new top right" do
      expect(@scaled.top_right).to eq(101.7)
    end

    it "takes the height of the mamdani value" do
      expect(@scaled.height).to eq(0.83)
    end
  end

  context "Mamdani with all points positive" do
    before do
      @t = FuzzyAssociativeMemory::Trapezoid.new(50, 80, 150, 160)
      @scaled = @t.mamdani(0.83)
    end

    it "stays a trapezoid" do
      expect(@scaled).to be_a(FuzzyAssociativeMemory::Trapezoid)
    end

    it "keeps same left and right corner points" do
      expect(@scaled.left).to eq(50)
      expect(@scaled.right).to eq(160)
    end

    it "gets the correct new top left" do
      expect(@scaled.top_left).to eq(74.9)
    end

    it "gets the correct new top right" do
      expect(@scaled.top_right).to eq(151.7)
    end

    it "takes the height of the mamdani value" do
      expect(@scaled.height).to eq(0.83)
    end
  end

end
