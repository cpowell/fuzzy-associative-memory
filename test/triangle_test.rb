gem 'minitest'
require 'minitest/autorun'

require "lib/triangle.rb"

# ruby ./test/triangle_test.rb

class TriangleTest < MiniTest::Unit::TestCase
  def setup
    @t = Triangle.new(10, 3, 3)
  end

  def test_dom_is_zero_outside_left_bound
    assert_equal(0, @t.calculate_dom(2))
  end

  def test_dom_is_zero_outside_right_bound
    assert_equal(0, @t.calculate_dom(15))
  end

  def test_dom_is_one_at_peak
    assert_equal(1.0, @t.calculate_dom(10))
  end

  def test_dom_is_half_at_half_right_offset
    assert_equal(0.5, @t.calculate_dom(11.5))
  end

  def test_dom_is_half_at_half_left_offset
    assert_equal(0.5, @t.calculate_dom(8.5))
  end
end
