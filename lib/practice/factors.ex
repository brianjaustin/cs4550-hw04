defmodule Practice.Factors do
  @moduledoc false

  @doc """
  Returns the list prime factors for a given positive number.

  ## Parameters

    - n: positive integer whose prime factors will be found

  ## Examples

    iex> Practice.Factors.prime(1)
    [1]

    iex> Practice.Factors.prime(4)
    [2, 2]

    iex> Practice.Factors.prime(1234)
    [2, 617]
  """
  @spec prime(non_neg_integer) :: [non_neg_integer]
  def prime(n) do
    prime_helper(n, 2)
  end

  defp prime_helper(n, f) do
    cond do
      f * f > n -> [n]
      rem(n, f) == 0 -> [f | prime_helper(div(n, f), f)]
      true -> prime_helper(n, f + 1)
    end
  end
end
