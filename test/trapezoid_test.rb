gem 'minitest'
require 'minitest/autorun'

require "lib/trapezoid.rb"

# ruby ./test/trapezoid_test.rb

class TrapezoidTest < MiniTest::Unit::TestCase
  def setup
    @t = Trapezoid.new(7, 10, 13, 16)
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
    t = Trapezoid.new(0, 5, 10, 15)
    assert_equal(0.6, t.mu(3.0))
  end

  def test_dom_is_correct_at_seven_tenths_offset
    t = Trapezoid.new(0, 5, 10, 15)
    assert_equal(0.6, t.mu(12.0))
  end

end
