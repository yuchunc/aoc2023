defmodule Day2 do
  import Util

  @cubes_in_bag %{"red" => 12, "green" => 13, "blue" => 14}

  def task1(input) do
    parse_input(input)
    |> Enum.map(&build_data/1)
    |> Enum.filter(&valid_sets/1)
    |> Enum.map(fn {index, _} -> index end)
    |> Enum.sum()
  end

  def task2(input) do
    parse_input(input)
    |> Enum.map(&build_data/1)
    |> Enum.map(&find_min_cubes/1)
    |> Enum.sum()
  end

  defp build_data(row) do
    [index_str, sets_str] = String.split(row, ": ", parts: 2)

    index =
      index_str
      |> String.split(" ")
      |> List.last()
      |> String.to_integer()

    sets = build_sets(sets_str)

    {index, sets}
  end

  defp build_sets(sets_str) do
    sets_str
    |> String.split(";")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&build_set/1)
  end

  defp build_set(set_str) do
    set_str
    |> String.split(", ")
    |> Enum.map(fn cube_str ->
      [count, color] = String.split(cube_str)

      {color, String.to_integer(count)}
    end)
  end

  defp valid_sets({_, sets}) do
    sets
    |> Enum.all?(fn set ->
      Enum.all?(set, fn {color, count} ->
        count <= @cubes_in_bag[color]
      end)
    end)
  end

  defp find_min_cubes({_, sets}) do
    sets
    |> List.flatten()
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Enum.map(&(&1 |> elem(1) |> Enum.max()))
    |> Enum.reduce(&Kernel.*/2)
  end
end
