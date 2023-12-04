defmodule Day4 do
  import Util

  def task1(input) do
    parse_input(input)
    |> Enum.map(&cast_card/1)
    |> Enum.map(fn card ->
      case get_winning_count(card) do
        0 -> 0
        count -> Integer.pow(2, count - 1)
      end
    end)
    |> Enum.sum()
  end

  def task2(input) do
    parse_input(input)
    |> Enum.map(&cast_card/1)
    |> calculate_cards(0)
  end

  defp calculate_cards([], acc), do: acc

  defp calculate_cards([card | cards], acc) do
    case get_winning_count(card) do
      0 ->
        {_, _, count} = card
        calculate_cards(cards, count + acc)

      won_count ->
        {won_cards, cards} = Enum.split(cards, won_count)

        {_, _, current_count} = card

        won_cards_updated_count =
          Enum.map(won_cards, fn {winning, matching, card_count} ->
            {winning, matching, current_count + card_count}
          end)

        calculate_cards(won_cards_updated_count ++ cards, current_count + acc)
    end
  end

  defp cast_card(str_card) do
    [[_, _str_card_num, str_winning_num, str_matching_num]] =
      Regex.scan(~r/^Card\s+(\d+): ([\d\s]+) \| ([\d\s]+)$/, str_card)

    {String.split(str_winning_num, " ", trim: true) |> MapSet.new(),
     String.split(str_matching_num, " ", trim: true) |> MapSet.new(), 1}
  end

  defp get_winning_count({winning_nums, matching_nums, _}) do
    matching_nums
    |> MapSet.intersection(winning_nums)
    |> MapSet.size()
  end
end
