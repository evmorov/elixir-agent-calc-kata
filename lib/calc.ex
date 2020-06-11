defmodule Calc do
  alias Calc.Memo

  def initial(n) do
    Memo.initial(n)
    |> Memo.add_history(n)
  end

  def add(memo, n) do
    memo
    |> Memo.update_result(n, &(&1 + &2))
    |> Memo.add_history("+")
    |> Memo.add_history(n)
  end

  def substract(memo, n) do
    memo
    |> Memo.update_result(n, &(&1 - &2))
    |> Memo.add_history("-")
    |> Memo.add_history(n)
  end

  def multiply(memo, n) do
    memo
    |> Memo.update_result(n, &(&1 * &2))
    |> Memo.add_history("*")
    |> Memo.add_history(n)
  end

  def divide(memo, n) do
    memo
    |> Memo.update_result(n, &(&1 / &2))
    |> Memo.add_history("/")
    |> Memo.add_history(n)
  end

  defdelegate result(memo), to: Memo
  defdelegate history(memo), to: Memo
end
