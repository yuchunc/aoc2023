defmodule Day3 do
  import Util

  @symbols ~w"* # + $ / @ & - = %"
  @str_numbers ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  def task1(input) do
    coords =
      input
      |> parse_input
      |> build_coords

    number_coords = build_number_coords(coords)

    coords
    |> Enum.filter(fn {data, _, _} -> data in @symbols end)
    |> Enum.map(&find_valid_part_numbers(&1, number_coords))
    |> List.flatten()
    |> Enum.sum()
  end

  def task2(input) do
    coords =
      input
      |> parse_input
      |> build_coords

    number_coords = build_number_coords(coords)

    coords
    |> Enum.filter(fn {data, _, _} -> data == "*" end)
    |> Enum.map(&find_gear_numbers(&1, number_coords))
    |> Enum.filter(&(length(&1) == 2))
    |> Enum.map(fn [{num1, _, _}, {num2, _, _}] ->
      num1 * num2
    end)
    |> Enum.sum()
  end

  defp build_coords(rows) do
    for {str_row, row_index} <- Enum.with_index(rows) do
      row = String.graphemes(str_row)

      for {data, col_index} <- Enum.with_index(row) do
        {data, row_index, col_index}
      end
    end
    |> List.flatten()
    |> Enum.reject(fn {data, _, _} -> data == "." end)
  end

  defp build_number_coords(coords) do
    coords
    |> Enum.filter(fn {data, _, _} -> data in @str_numbers end)
    |> merge_number({}, [])
  end

  defp merge_number([], {}, acc), do: acc

  defp merge_number([], {_, _, _} = number_coords, acc), do: [convert_to_int(number_coords) | acc]

  defp merge_number([{_, _, curr_col} = data | t], {_, _, [prev_col | _]} = number_coords, acc)
       when prev_col + 1 != curr_col do
    merge_number(t, do_merge(data, {}), [convert_to_int(number_coords) | acc])
  end

  defp merge_number([{_, curr_row, _} = data | t], {_, prev_row, _} = number_coords, acc)
       when curr_row != prev_row do
    merge_number(t, do_merge(data, {}), [convert_to_int(number_coords) | acc])
  end

  defp merge_number([data | t], number_coords, acc) do
    merge_number(t, do_merge(data, number_coords), acc)
  end

  defp do_merge(data, {}) do
    {number, row, col} = data
    {number, row, [col]}
  end

  defp do_merge(curr_data, {number_acc, _, cols}) do
    {number, row, col} = curr_data
    {number_acc <> number, row, [col | cols]}
  end

  defp convert_to_int({number, row, range}), do: {String.to_integer(number), row, range}

  defp find_valid_part_numbers({_, row, col}, number_coords) do
    Enum.filter(number_coords, fn {_, num_row, num_cols} ->
      num_row in (row - 1)..(row + 1) &&
        length(num_cols -- [col - 1, col, col + 1]) != length(num_cols)
    end)
    |> Enum.map(&elem(&1, 0))
    |> List.flatten()
  end

  defp find_gear_numbers({_, row, col}, number_coords) do
    Enum.filter(number_coords, fn {_, num_row, num_cols} ->
      num_row in (row - 1)..(row + 1) &&
        length(num_cols -- [col - 1, col, col + 1]) != length(num_cols)
    end)
  end
end
