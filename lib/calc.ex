defmodule Calc do
  def initial(n) do
    {:ok, pid} = Cache.start(n)
    pid
  end

  def add(pid, n) do
    Cache.put(pid, "+", n)
    pid
  end

  def substract(pid, n) do
    Cache.put(pid, "-", n)
    pid
  end

  def multiply(pid, n) do
    Cache.put(pid, "*", n)
    pid
  end

  def divide(pid, n) do
    Cache.put(pid, "/", n)
    pid
  end

  def history(pid) do
    %{history: history, result: result} = Cache.get(pid)
    "#{history} = #{result}"
  end

  def result(pid) do
    %{result: result} = Cache.get(pid)
    result
  end
end

defmodule Cache do
  def start(n) do
    Agent.start(fn -> %{history: "#{n}", result: n} end)
  end

  def get(pid) do
    Agent.get(pid, & &1)
  end

  def put(pid, operand, value) do
    Agent.update(
      pid,
      &%{
        history: "#{&1.history} #{operand} #{value}",
        result: "#{&1.result} #{operand} #{value}" |> Code.eval_string() |> elem(0) |> round()
      }
    )
  end
end
