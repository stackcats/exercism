defmodule Garden do
  @default_names [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]
  @plants %{?V => :violets, ?G => :grass, ?C => :clover, ?R => :radishes}

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    student_names = Enum.sort(student_names)

    garden_info =
      Enum.reduce(student_names, %{}, fn name, acc ->
        Map.put(acc, name, {})
      end)

    info_string
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.zip()
    |> Enum.chunk_every(2)
    |> Enum.zip(student_names)
    |> Enum.reduce(garden_info, fn {[{r11, r12}, {r21, r22}], name}, garden_info ->
      plants = {@plants[r11], @plants[r21], @plants[r12], @plants[r22]}
      Map.put(garden_info, name, plants)
    end)
  end
end
