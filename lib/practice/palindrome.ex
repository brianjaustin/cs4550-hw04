defmodule Practice.Palindrome do
  @moduledoc false

  @doc """
  Given a word, determines if it is palindrome.

  ## Parameters

    - word: the word to check

  ## Examples

    iex> Practice.Palindrome.palindrome?("foo")
    false

    iex> Practice.Palindrome.palindrome?("racecar")
    true
  """
  @spec palindrome?(String.t()) :: boolean
  def palindrome?(word) do
    all_lower = String.downcase(word)
    all_lower == String.reverse(all_lower)
  end
end
