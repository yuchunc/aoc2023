defmodule Util do
  def parse_input(input, opts \\ []) do
    split_by = Keyword.get(opts, :split_by, "\n")

    if input =~ "priv" do
      File.read!(input)
    else
      input
    end
    |> String.trim()
    |> String.split(split_by, trim: true)
  end
end
