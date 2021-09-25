defmodule F1 do
  # ---------------------------------------------------------------------------

  # 1.
  @spec osszetett(k :: integer) :: xs :: [integer]
  # A 4..k*k közötti összetett számok növekvő listája, ismétlődés nélkül
  def osszetett(k) do
    # '//' (step) opció csak az Elixir v1.12-től van
    # :lists.usort(for i <- 2..k, j <- (i * 2)..(k * k) // i, do: j)
    :lists.usort(
      for i <- 2..k, j <- (i * 2)..(k * k) do
        IO.inspect(j)
        j
      end
    )
  end

  # ---------------------------------------------------------------------------
end

IO.inspect(F1.osszetett(5))
