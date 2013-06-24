gem 'minitest'
require 'minitest/autorun'

require "lib/right_shoulder.rb"

# ruby ./test/right_shoulder_test.rb

class RightShoulderTest < MiniTest::Unit::TestCase
  def setup
    @t = RightShoulder.new(7, 10, 50)
  end

  def test_dom_is_one_right_of_peak
    assert_equal(1, @t.dom(12))
  end

  def test_dom_is_one_well_past_right_offset
    assert_equal(1, @t.dom(500))
  end

  def test_dom_is_zero_outside_left_bound
    assert_equal(0, @t.dom(1))
  end

  def test_dom_is_one_at_peak
    assert_equal(1.0, @t.dom(10))
  end

  def test_dom_is_half_at_half_left_offset
    assert_equal(0.5, @t.dom(8.5))
  end
end
