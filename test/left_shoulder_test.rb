gem 'minitest'
require 'minitest/autorun'

require "lib/left_shoulder.rb"

# ruby ./test/left_shoulder_test.rb

class LeftShoulderTest < MiniTest::Unit::TestCase
  def setup
    @t = LeftShoulder.new(10, 3, 3)
  end

  def test_dom_is_one_left_of_peak
    assert_equal(1, @t.calculate_dom(9))
  end

  def test_dom_is_one_well_past_left_offset
    assert_equal(1, @t.calculate_dom(0))
  end

  def test_dom_is_zero_outside_right_bound
    assert_equal(0, @t.calculate_dom(50))
  end

  def test_dom_is_one_at_peak
    assert_equal(1.0, @t.calculate_dom(10))
  end

  def test_dom_is_half_at_half_right_offset
    assert_equal(0.5, @t.calculate_dom(11.5))
  end
end
