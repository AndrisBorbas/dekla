defmodule Khf2 do
  @moduledoc """
  Szövegelő
  @author "Borbás András <andris.borbas@gmail.com>"
  @date   "2021-10-03"
  """
  @doc """
  A szovegelo függvény egy szövegfájl tartalmából mátrixot állít elő.
  """
  @spec szovegelo(file :: String.t()) :: rss :: [[String.t() | nil]]
  # A file fájl tartalmából előállítja az rss szövegmátrixot.
  # A beolvasott szöveg és a szövegmátrix sorainak száma azonos.
  # A szövegmátrix oszlopainak száma megegyezik a leghosszabb
  # sor szavainak számával. A mátrix minden egyes cellájában a
  # fájl egy-egy szava vagy a nil atom van. A szavakat egy vagy
  # több szóköz-jellegű karakter választja el. A sorokba balról
  # jobbra haladva kerülnek be a szavak, a sorok végén üresen
  # maradó cellákba pedig a nil atom.
  def szovegelo(file) do
    input =
      Enum.filter(
        Enum.map(
          String.split(File.read!(file), "\n"),
          fn line -> String.split(line) end
        ),
        fn words -> length(words) > 0 end
      )

    cond do
      length(input) < 1 ->
        []

      true ->
        maxLen =
          Enum.max(
            Enum.map(
              input,
              fn line -> length(line) end
            )
          )

        for row <- 0..(length(input) - 1) do
          for col <- 0..(maxLen - 1) do
            Enum.at(Enum.at(input, row) || [], col)
          end
        end
    end
  end
end
