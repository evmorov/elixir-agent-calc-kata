defmodule Calc.Memo do
  def initial(n) do
    {:ok, pid} = Agent.start_link(fn -> %{result: n, history: []} end)
    pid
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

  def update_result(pid, n, operation) do
    Agent.get_and_update(pid, fn state ->
      {state, Map.put(state, :result, operation.(state[:result], n))}
    end)

    pid
  end

  def add_history(pid, n) do
    Agent.get_and_update(pid, fn state ->
      {state, Map.put(state, :history, [n | state[:history]])}
    end)

    pid
  end
end
