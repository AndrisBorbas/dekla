defmodule F1 do
  @spec lnko(a :: integer, b :: integer) :: d :: integer
  # a ás b legnagyobb közös osztója d
  def lnko(a, 0), do: a

  def lnko(a, b) do
    lnko(b, rem(a, b))
  end
end

IO.puts(F1.lnko(96, 42))

defmodule F2 do
  @spec len(xs :: [any]) :: n :: integer
  # Az xs lista hossza
  def len([]), do: 0

  def len(xs) do
    1 + len(tl(xs))
  end

  @spec leni(xs :: [any]) :: n :: integer
  # Az xs lista hossza n
  def leni
end

IO.puts(F2.len([]))
IO.puts(F2.len('Poogers'))
