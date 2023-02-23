# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {[], 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {lst, _} -> lst end)
  end

  def register(pid, register_to) do
    curr_id = Agent.get(pid, fn {_, curr_id} -> curr_id end)
    plot = %Plot{plot_id: curr_id, registered_to: register_to}

    Agent.update(pid, fn {lst, curr_id} ->
      {[plot | lst], curr_id + 1}
    end)

    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {lst, curr_id} ->
      {lst |> Enum.reject(fn plot -> plot.plot_id == plot_id end), curr_id}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {lst, _} ->
      Enum.find(lst, {:not_found, "plot is unregistered"}, fn plot -> plot.plot_id == plot_id end)
    end)
  end
end
