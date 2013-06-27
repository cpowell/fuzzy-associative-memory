gem 'minitest'
require 'minitest/autorun'

$:.push File.expand_path('../../lib/', __FILE__)
require 'fuzzy_associative_memory'

# ruby ./test/trapezoid_test.rb

class TrapezoidTest < MiniTest::Unit::TestCase
  def setup
    @t = FuzzyAssociativeMemory::Trapezoid.new(7, 10, 13, 16)
  end

  def test_dom_is_zero_outside_left_bound
    assert_equal(0, @t.mu(2))
  end

  def test_dom_is_zero_at_left
    assert_equal(0, @t.mu(7))
  end

  def test_dom_is_half_at_half_left_offset
    assert_equal(0.5, @t.mu(8.5))
  end

  def test_dom_is_one_at_top_left
    assert_equal(1.0, @t.mu(10))
  end

  def test_dom_is_one_at_top_right
    assert_equal(1.0, @t.mu(13))
  end

  def test_dom_is_half_at_half_right_offset
    assert_equal(0.5, @t.mu(14.5))
  end

  def test_dom_is_zero_at_right
    assert_equal(0, @t.mu(16))
  end

  def test_dom_is_zero_outside_right_bound
    assert_equal(0, @t.mu(17))
  end

  def test_dom_is_correct_at_three_fifths_offset
    t = FuzzyAssociativeMemory::Trapezoid.new(0, 5, 10, 15)
    assert_equal(0.6, t.mu(3.0))
  end

  def test_dom_is_correct_at_seven_tenths_offset
    t = FuzzyAssociativeMemory::Trapezoid.new(0, 5, 10, 15)
    assert_equal(0.6, t.mu(12.0))
  end

  def test_centroid_calculation_1
    t = FuzzyAssociativeMemory::Trapezoid.new(0, 20, 50, 50)
    assert_equal(29.583333333333332, t.centroid_x)
  end

  def test_centroid_calculation_2
    t = FuzzyAssociativeMemory::Trapezoid.new(0, 10, 20, 30)
    assert_equal(15.0, t.centroid_x)
  end

  def test_centroid_calculation_when_not_starting_at_zero
    t = FuzzyAssociativeMemory::Trapezoid.new(50, 80, 100, 100)
    assert_equal(81.42857142857143, t.centroid_x)
  end

  def test_dom_1
    t = FuzzyAssociativeMemory::Trapezoid.new(20, 30, 40, 50)
    assert_equal(0.9, t.mu(41))
  end

  def test_mamdani_clipping_1
    t = FuzzyAssociativeMemory::Trapezoid.new(0, 30, 100, 110)
    t2 = t.mamdani(0.83)
    assert_equal(0, t2.left)
    assert_equal(24.9, t2.top_left)
    assert_equal(101.7, t2.top_right)
    assert_equal(110, t2.right)
    assert_equal(0.83, t2.height)
  end

  def test_mamdani_clipping_2
    t = FuzzyAssociativeMemory::Trapezoid.new(50, 80, 150, 160)
    t2 = t.mamdani(0.83)
    assert_equal(50, t2.left)
    assert_equal(74.9, t2.top_left)
    assert_equal(151.7, t2.top_right)
    assert_equal(160, t2.right)
    assert_equal(0.83, t2.height)
  end

end
