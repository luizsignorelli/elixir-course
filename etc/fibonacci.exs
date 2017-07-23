defmodule FibCache do
  def start do
    Agent.start_link(fn -> %{ 0 => 0, 1 => 1} end)
  end

  def get(agent, n) do
    Agent.get(agent, fn(cache) -> Map.get(cache, n) end)
  end

  def put(agent, n, fib) do
    Agent.update(agent, fn(cache) -> Map.put(cache, n, fib) end)
  end
end

defmodule Fib do
  def of(n) do
    {:ok, cache } = FibCache.start()

    compute_or_get(n, FibCache.get(cache, n), cache)
  end

  def compute_or_get(n, nil, cache) do
    n_2 = compute_or_get(n-2, FibCache.get(cache, n-2), cache)
    FibCache.put(cache, n-2, n_2)
    
    n_1 = compute_or_get(n-1, FibCache.get(cache, n-1), cache)
    FibCache.put(cache, n-1, n_1)

    n_1 + n_2
  end
  def compute_or_get(_, value, _), do: value
end
