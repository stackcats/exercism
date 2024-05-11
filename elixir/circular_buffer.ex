defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    Agent.start(fn -> {capacity, []} end)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    Agent.get_and_update(buffer, fn
      {cap, []} -> {{:error, :empty}, {cap, []}}
      {cap, [x | xs]} -> {{:ok, x}, {cap, xs}}
    end)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    Agent.get_and_update(buffer, fn {cap, xs} ->
      if length(xs) == cap do
        {{:error, :full}, {cap, xs}}
      else
        {:ok, {cap, xs ++ [item]}}
      end
    end)
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    Agent.get_and_update(buffer, fn {cap, xs} ->
      xs = if length(xs) == cap, do: tl(xs), else: xs
      {:ok, {cap, xs ++ [item]}}
    end)
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    Agent.get_and_update(buffer, fn {cap, _} -> {:ok, {cap, []}} end)
  end
end
