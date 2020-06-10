defmodule SolutionTest do
  use ExUnit.Case

  test "test_correct" do
    assert Solution.sum(1, 3) == 4
  end

  test "test_mistake" do
    assert Solution.sum(1, 3) == 5
  end
end
