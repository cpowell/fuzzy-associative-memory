require 'spec_helper'

describe "Triangle" do
  before :all do
    # per-context setup
  end

  before do
    # per-example setup
    @t = FuzzyAssociativeMemory::Triangle.new(7, 10, 13)
  end

  after do
    # per-example teardown
  end

  after :all do
    # per-context teardown
  end

  it "has centroid of peak for isoceles triangle" do
    expect(@t.centroid_x).to eq(10)
  end

  it "has DOM 0 outside left bound" do
    expect(@t.mu(2)).to eq(0)
  end

  it "has DOM 0 outside right bound" do
    expect(@t.mu(15)).to eq(0)
  end

  it "has DOM 1 at peak" do
    expect(@t.mu(10)).to eq(1.0)
  end

  it "has DOM 0.5 at half right offset" do
    expect(@t.mu(11.5)).to eq(0.5)
  end

  it "has DOM 0.5 at half left offset" do
    expect(@t.mu(8.5)).to eq(0.5)
  end

  it "has correct DOM at 3/5 offset" do
    @t = FuzzyAssociativeMemory::Triangle.new(0, 5, 10)
    expect(@t.mu(3.0)).to eq(0.6)
  end

  it "has correct DOM at 7/10 offset" do
    @t = FuzzyAssociativeMemory::Triangle.new(0, 5, 10)
    expect(@t.mu(7.0)).to eq(0.6)
  end

  context "Larsen implication" do
    before do
      @scaled = @t.larsen(0.15)
    end

    it "takes the height of the larsen value" do
      expect(@scaled.height).to eq(0.15)
    end

    it "keeps right, left and center" do
      expect(@scaled.left).to eq(7)
      expect(@scaled.right).to eq(13)
      expect(@scaled.center).to eq(10)
    end
  end

  context "Mamdani implication" do
    before do
      @scaled = @t.mamdani(0.83)
    end

    it "becomes a trapezoid" do
      expect(@scaled).to be_a(FuzzyAssociativeMemory::Trapezoid)
    end

    it "keeps left and right" do
      expect(@scaled.left).to eq(7)
      expect(@scaled.right).to eq(13)
    end

    it "gets a proper top left" do
      expect(@scaled.top_left).to eq(9.49)
    end

    it "gets a proper top right" do
      expect(@scaled.top_right).to eq(10.51)
    end

    it "takes the height of the mamdani value" do
      expect(@scaled.height).to eq(0.83)
    end
  end
end
