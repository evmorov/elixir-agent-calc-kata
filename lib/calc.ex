defmodule Calc do
  def initial(n) do
    {:ok, pid} = Agent.start_link(fn -> %{result: n, history: []} end)
    add_history(pid, n)
  end

  def add(pid, n) do
    pid
    |> add_history("+")
    |> update_result(n, fn result, n -> result + n end)
  end

  def substract(pid, n) do
    pid
    |> add_history("-")
    |> update_result(n, fn result, n -> result - n end)
  end

  def multiply(pid, n) do
    pid
    |> add_history("*")
    |> update_result(n, fn result, n -> result * n end)
  end

  def divide(pid, n) do
    pid
    |> add_history("/")
    |> update_result(n, fn result, n -> result / n end)
  end

  def result(pid) do
    Agent.get(pid, fn state -> floor(state[:result]) end)
  end

  def history(pid) do
    Agent.get(pid, fn state ->
      [floor(state[:result]) | ["=" | state[:history]]]
      |> Enum.reverse()
      |> Enum.join(" ")
    end)
  end

  defp update_result(pid, n, operation) do
    pid
    |> add_history(n)
    |> Agent.get_and_update(fn state ->
      {state, Map.put(state, :result, operation.(state[:result], n))}
    end)

    pid
  end

  defp add_history(pid, n) do
    Agent.get_and_update(pid, fn state ->
      {state, Map.put(state, :history, [n | state[:history]])}
    end)

    pid
  end
end
