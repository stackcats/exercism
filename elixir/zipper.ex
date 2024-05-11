defmodule Zipper do
  @type t :: %Zipper{focus: BinTree.t(), parents: list()}

  defstruct focus: nil, parents: []
  
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{focus: bin_tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{focus: focus, parents: []}) do
    focus
  end
  def to_tree(zipper) do
    zipper |> up() |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{focus: focus, parents: parents}) do
    case focus.left do
      nil -> nil
      _ -> %Zipper{focus: focus.left, parents: [{:left, focus}|parents]}
    end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{focus: focus, parents: parents}) do
    case focus.right do
      nil -> nil
      _ -> %Zipper{focus: focus.right, parents: [{:right, focus}|parents]}
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{parents: []}), do: nil
  def up(%Zipper{focus: focus, parents: [{dir, p}|ps]}) do
    %Zipper{focus: Map.put(p, dir, focus), parents: ps}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    put_in(zipper.focus.value, value)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    put_in(zipper.focus.left, left)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    put_in(zipper.focus.right, right)
  end
end

