defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0 do
      %{dot | opacity: dot.opacity / 2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init([velocity: v] = opts) when is_number(v) do
      {:ok, opts}
  end

  @impl DancingDots.Animation
  def init([velocity: v]) do
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(v)}"}
  end

  @impl DancingDots.Animation
  def init(opts), do: init([velocity: nil])

  @impl DancingDots.Animation
  def handle_frame(dot, 1, _opts), do: dot

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, [velocity: v]) do
    %{dot | radius: dot.radius + (frame_number - 1) * v}
  end
end

