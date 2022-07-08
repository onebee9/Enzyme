require "test/unit"
require_relative "hash_compare"

class TestHashCompare < Test::Unit::TestCase

  def test_shallow_compare_diff
    
    shallow_compare_1 = {"a":1, "b":2}
    shallow_compare_2= {"a":1, "b":2, "c":3}

    hc = HashCompare.new(shallow_compare_1, shallow_compare_2)
    assert_equal({"c":3}, hc.hash_compare)
  end

  def test_deep_compare_diff
    
    deep_compare_1 = {"a": 1, "b": 2, "c": {"d": {'l': 7 }}, "e": 4, "f": 5}
    deep_compare_2 = {"a": 1, "b": 3, "c": {"d": {'p': 2},  "z": 10}, "g": 6, "h": 7}

    hc = HashCompare.new(deep_compare_1, deep_compare_2,'deep')
    assert_equal({:b=>3, :c=>{:d=>{:l=>7, :p=>2}, :z=>10}, :e=>4, :f=>5, :g=>6, :h=>7}, hc.hash_compare)
  end

  def test_empty_hash_compare
    
    empty_1 = {}
    hash_1 = {"a": 1, "b": 3, "c": {"d": {'p': 2},  "z": 10}, "g": 6, "h": 7}

    hc = HashCompare.new(empty_1, hash_1)
    assert_equal({"a": 1, "b": 3, "c": {"d": {'p': 2},  "z": 10}, "g": 6, "h": 7}, hc.hash_compare)
  end

  def test_equal_hash_compare
    
    eq2 = {"a": 1, "b": 3, "c": {"d": {'p': 2},  "z": 10}, "g": 6, "h": 7}
    eq3 = {"a": 1, "b": 3, "c": {"d": {'p': 2},  "z": 10}, "g": 6, "h": 7}

    hc = HashCompare.new(eq2, eq3)
    assert_equal({}, hc.hash_compare)
  end

end