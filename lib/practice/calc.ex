defmodule Practice.Calc do
  # Apply the given function to the list of arguments.
  # To preserve order, the list is reversed first.
  defp args_apply(ast, op) when is_list(ast) do
    ast
    |> Enum.map(&eval_ast/1)
    |> Enum.reverse
    |> Enum.reduce(op)
  end

  defp args_apply(_ast, _op), do: :error

  defp eval_ast(ast) when is_number(ast), do: ast

  # Evaluate an AST for simple arithmetic expressions.
  # Operator precedence is respected, parentheses are not
  # supported.
  defp eval_ast(ast) do
    case ast do
      {:+, _, args} -> args_apply(args, &+/2)
      {:-, _, args} -> args_apply(args, &-/2)
      {:*, _, args} -> args_apply(args, &*/2)
      {:/, _, args} -> args_apply(args, &//2)
      _ -> "Error evaluating expression"
    end
  end

  @doc """
  Parses the given simple arithmetic expression
  following operator precedence.

  ## Parameters

    - expr: arithmetic expression to parse


  ## Examples

    iex> Practice.Calc.calc("5")
    5

    iex> Practice.Calc.calc("1+3*2")
    7

    iex> Practice.Calc.calc("abc")
    "Error evaluating expression"

    iex> Practice.Calc.calc("5+")
    "Error parsing expression"
  """
  def calc(expr) do
    # First, use Elixir's metaprogramming capabilities
    # to parse the input into an abstract syntax tree
    # (AST). Then, evalutate that tree to produce the result.
    with {:ok, ast} <- Code.string_to_quoted(expr),
         result <- eval_ast(ast) do
        result
    else
      {:error, _} -> "Error parsing expression"
      _ -> "Unknown error"
    end
  end
end
