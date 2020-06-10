defmodule CalcTest do
  use ExUnit.Case

  # @tag :pending
  test "initial" do
    assert Calc.initial(5) |> Calc.result() == 5
  end

  @tag :pending
  test "add" do
    assert Calc.initial(5) |> Calc.add(3) |> Calc.result() == 8
  end

  @tag :pending
  test "substract" do
    assert Calc.initial(8) |> Calc.substract(3) |> Calc.result() == 5
  end

  @tag :pending
  test "multiply" do
    assert Calc.initial(5) |> Calc.multiply(6) |> Calc.result() == 30
  end

  @tag :pending
  test "divide" do
    assert Calc.initial(30) |> Calc.divide(5) |> Calc.result() == 6
  end

  @tag :pending
  test "history" do
    assert Calc.initial(0)
    |> Calc.add(5)
    |> Calc.substract(3)
    |> Calc.multiply(10)
    |> Calc.divide(4)
    |> Calc.history() == "0 + 5 - 3 * 10 / 4 = 5"
  end
end
