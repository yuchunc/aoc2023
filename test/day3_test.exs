defmodule Day3Test do
  use ExUnit.Case, async: true

  @sample """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  test "task1" do
    assert Day3.task1(@sample) == 4361
  end

  test "task2" do
    assert Day3.task2(@sample) == 467_835
  end
end
