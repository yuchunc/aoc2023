defmodule Day1 do
  import Util

  @name_int ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

  @reverse_name_int ["eno", "owt", "eerht", "ruof", "evif", "xis", "neves", "thgie", "enin"]

  def task1(input) do
    parse_input(input)
    |> Enum.map(&cast_to_ints/1)
    |> Enum.sum()
  end

  def task2(input) do
    parse_input(input)
    |> Enum.map(&cast_include_str_ints/1)
    |> Enum.sum()
  end

  defp cast_to_ints(row) do
    list_ints =
      ~r/\d/
      |> Regex.scan(row)
      |> List.flatten()

    (List.first(list_ints) <> List.last(list_ints))
    |> String.to_integer()
  end

  defp cast_include_str_ints(row) do
    first_str_int =
      ~r/(one|two|three|four|five|six|seven|eight|nine|\d)/
      |> Regex.scan(row)
      |> List.flatten()
      |> List.first()
      |> convert_to_str_int

    last_str_int =
      ~r/(eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|\d)/
      |> Regex.scan(String.reverse(row))
      |> List.flatten()
      |> List.first()
      |> convert_to_str_int_reverse

    (first_str_int <> last_str_int)
    |> String.to_integer()
  end

  def convert_to_str_int(name_int) when name_int in @name_int do
    map = @name_int |> Enum.with_index(&{&1, &2 + 1}) |> Map.new()
    to_string(map[name_int])
  end

  def convert_to_str_int(int), do: int

  def convert_to_str_int_reverse(name_int) when name_int in @reverse_name_int do
    map = @reverse_name_int |> Enum.with_index(&{&1, &2 + 1}) |> Map.new()
    to_string(map[name_int])
  end

  def convert_to_str_int_reverse(str_int), do: str_int
end
