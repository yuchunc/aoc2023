defmodule Day1Test do
  use ExUnit.Case, async: true

  test "task 1" do
    caliberate_doc = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    assert Day1.task1(caliberate_doc) == 142
  end

  test "task 2" do
    caliberate_doc = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    assert Day1.task2(caliberate_doc) == 281
  end

  test "task 2 with overlaping name_int" do
    sample = "6fourkm9mnnrbjpjtwozdgtrsseightwox"

    assert Day1.task2(sample) == 62
  end
end
