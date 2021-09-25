defmodule Khf1 do
  @moduledoc """
  101 kiskutya
  @author "Borbás András <andris.borbas@gmail.com>"
  @date   "2021-09-21"
  """

  @type variant :: {h :: integer, d :: integer}
  @type seatings :: {n :: integer, vs :: [variant]}

  @spec sit!(k :: integer) :: r :: {m :: integer, ss :: [seatings]}
  # k kiskutya m-féleképpen ülhet úgy n>2 sorban, hogy a leghátsó sorban
  # h kiskutya ül, a számuk pedig soronként pontosan d-vel növekszik
  def sit!(0), do: {0, []}
  def sit!(1), do: {0, []}

  def sit!(k) do
    l =
      Enum.filter(
        :lists.usort(
          for n <- 3..ceil(k / 2) do
            temp =
              :lists.usort(
                for start <- 1..ceil(k / 2),
                    diff <- 1..ceil(k / 2),
                    szam_sor_ossz(start, diff, n) === k do
                  {start, diff}
                end
              )

            cond do
              length(temp) == 0 -> nil
              length(temp) != 0 -> {n, temp}
            end
          end
        ),
        &(!is_nil(&1))
      )

    {Enum.sum(for i <- l, do: length(elem(i, 1))), l}
  end

  @spec good_flocks(kmax :: integer) :: ks :: [k :: integer]
  # A ks lista elemei azoknak a kutyafalkáknak a k számossága
  # (2 < k <= kmax), amelyek a feladatban megadott feltételekkel
  # leültethetők a képernyő elé
  def good_flocks(kmax) do
    for i <- 2..kmax, elem(sit!(i), 0) > 0, do: i
  end

  @spec szam_sor_ossz(s :: integer, d :: integer, n :: integer) :: sum :: integer
  # A szam_sor_ossz függvény kiszámítja az
  # s kezdőértékű,
  # d különbségű,
  # n elemű számtani sorozat összegét.
  defp szam_sor_ossz(_s, _d, 0), do: 0

  defp szam_sor_ossz(s, d, n) do
    szam_sor_ossz(s + d, d, n - 1) + s
  end
end
