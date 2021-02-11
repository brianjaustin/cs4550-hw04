defmodule Practice.Calc do
  @moduledoc false

  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  # Functions for parsing tokens
  defp tag_token("+"), do: {:op, "+"}
  defp tag_token("-"), do: {:op, "-"}
  defp tag_token("*"), do: {:op, "*"}
  defp tag_token("/"), do: {:op, "/"}

  defp tag_token(num) do
    {:num, parse_float(num)}
  end

  # Functions for converting from infix to postfix form
  # using the [Shunting Yard Algorithm]
  # (https://brilliant.org/wiki/shunting-yard-algorithm/).
  defp precedence("+"), do: 2
  defp precedence("-"), do: 2
  defp precedence("*"), do: 1
  defp precedence("/"), do: 1

  defp handle_op(op, rest, acc, []) do
    to_postfix(rest, acc, [op])
  end

  defp handle_op(op, rest, acc, [op_head | op_tail] = ops) do
    if precedence(op_head) <= precedence(op) do
      handle_op(op, rest, [op_head | acc], op_tail)
    else
      to_postfix(rest, acc, [op | ops])
    end
  end

  defp to_postfix([], acc, ops) do
    Enum.reverse(acc) ++ ops
  end

  defp to_postfix([tok | tail], acc, ops) do
    case tok do
      {:num, n} -> to_postfix(tail, [n | acc], ops)
      {:op, op} -> handle_op(op, tail, acc, ops)
    end
  end

  # Functions to evaluate postfix arithmetic expression
  # using reverse-Polish notation. More info on RPN:
  # https://brilliant.org/wiki/shunting-yard-algorithm/#reverse-polish.
  defp apply_op(op, [x, y | tail]) do
    [op.(y, x) | tail]
  end

  defp eval("+", acc), do: apply_op(&+/2, acc)
  defp eval("-", acc), do: apply_op(&-/2, acc)
  defp eval("*", acc), do: apply_op(&*/2, acc)
  defp eval("/", acc), do: apply_op(&//2, acc)
  defp eval(n, acc), do: [n | acc]

  # Helper function to handle result
  defp simplify_result([res | []]) do
    if trunc(res) == res do
      trunc(res)
    else
      res
    end
  end

  defp simplify_result(_), do: "Unknown error occurred"

  @doc """
  Parses the given simple arithmetic expression
  following operator precedence.

  ## Parameters

    - expr: arithmetic expression to parse


  ## Examples

    iex> Practice.Calc.calc("5")
    5

    iex> Practice.Calc.calc("1 + 3 * 2 / 1")
    7
  """
  def calc(expr) do
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(&tag_token/1)
    |> to_postfix([], [])
    |> Enum.reduce([], &eval/2)
    |> simplify_result()
  end
end
