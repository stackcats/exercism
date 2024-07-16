defmodule React do
  use GenServer

  defmodule Cell do
    defstruct [:name, :inputs, :cp, :value, cb: %{}]
    def get_value(%Cell{cp: nil, value: value}, _), do: value

    def get_value(cell, reactor) do
      vs = Enum.map(cell.inputs, fn i -> get_value(reactor[i], reactor) end)
      apply(cell.cp, vs)
    end
  end

  @opaque cells :: pid

  @type cell :: {:input, String.t(), any} | {:output, String.t(), [String.t()], fun()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
    GenServer.start_link(__MODULE__, cells)
  end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
    GenServer.call(cells, {:get_value, cell_name})
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
    GenServer.cast(cells, {:set_value, cell_name, value})
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
    GenServer.cast(cells, {:add_callback, cell_name, callback_name, callback})
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, cell_name, callback_name) do
    GenServer.cast(cells, {:remove_callback, cell_name, callback_name})
  end

  @impl true
  def init(state) do
    state =
      state
      |> Map.new(fn
        {:input, name, value} ->
          {name, %Cell{name: name, value: value}}

        {:output, name, inputs, cp} ->
          {name, %Cell{name: name, inputs: inputs, cp: cp}}
      end)

    state =
      state
      |> Map.new(fn {name, cell} ->
        value = Cell.get_value(cell, state)
        {name, %{cell | value: value}}
      end)

    {:ok, state}
  end

  @impl true
  def handle_call({:get_value, name}, _from, state) do
    {:reply, state[name].value, state}
  end

  @impl true
  def handle_cast({:set_value, name, value}, state) do
    case state[name].value do
      ^value ->
        {:noreply, state}

      _ ->
        state = put_in(state, [name, Access.key(:value, nil)], value)
        {:noreply, update(state)}
    end
  end

  @impl true
  def handle_cast({:add_callback, cell_name, callback_name, callback}, state) do
    state =
      update_in(state, [cell_name, Access.key(:cb, %{})], &Map.put(&1, callback_name, callback))

    {:noreply, state}
  end

  @impl true
  def handle_cast({:remove_callback, cell_name, callback_name}, state) do
    state = update_in(state, [cell_name, Access.key(:cb, %{})], &Map.delete(&1, callback_name))
    {:noreply, state}
  end

  defp update(state) do
    state
    |> Map.new(fn
      {name, %Cell{cp: nil} = cell} ->
        {name, cell}

      {name, cell} ->
        value = Cell.get_value(cell, state)

        if value == cell.value do
          {name, cell}
        else
          cell = %{cell | value: value}
          Enum.each(cell.cb, fn {n, f} -> f.(n, value) end)
          {name, cell}
        end
    end)
  end
end
