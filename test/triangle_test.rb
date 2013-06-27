gem 'minitest'
require 'minitest/autorun'

$:.push File.expand_path('../../lib/', __FILE__)
require 'fuzzy_associative_memory'

# ruby ./test/triangle_test.rb

class TriangleTest < MiniTest::Unit::TestCase
  def setup
    @t = FuzzyAssociativeMemory::Triangle.new(7, 10, 13)
  end

  def test_dom_is_zero_outside_left_bound
    assert_equal(0, @t.mu(2))
  end

  def test_dom_is_zero_outside_right_bound
    assert_equal(0, @t.mu(15))
  end

  def test_dom_is_one_at_peak
    assert_equal(1.0, @t.mu(10))
  end

  def test_dom_is_half_at_half_right_offset
    assert_equal(0.5, @t.mu(11.5))
  end

  def test_dom_is_half_at_half_left_offset
    assert_equal(0.5, @t.mu(8.5))
  end

  def test_dom_is_correct_at_three_fifths_offset
    t = FuzzyAssociativeMemory::Triangle.new(0, 5, 10)
    assert_equal(0.6, t.mu(3.0))
  end

  def test_dom_is_correct_at_seven_tenths_offset
    t = FuzzyAssociativeMemory::Triangle.new(0, 5, 10)
    assert_equal(0.6, t.mu(7.0))
  end

  def test_centroid_calculation
    t = FuzzyAssociativeMemory::Triangle.new(5, 10, 15)
    assert_equal(10.0, t.centroid_x)
  end

  def test_larsen_scaling
    scaled = @t.larsen(0.15)
    assert_equal(0.15, scaled.height)
  end

  def test_mamdani_clipping_1
    t2 = @t.mamdani(0.83)
    assert(t2.is_a? FuzzyAssociativeMemory::Trapezoid)
    assert_equal(7, t2.left)
    assert_equal(9.49, t2.top_left)
    assert_equal(10.51, t2.top_right)
    assert_equal(13, t2.right)
    assert_equal(0.83, t2.height)
  end

end
