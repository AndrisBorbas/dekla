defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end

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

s0 =
  IO.inspect(Khf2.szovegelo("khf2_s0.txt")) ===
    []

s1 =
  IO.inspect(Khf2.szovegelo("khf2_s1.txt")) ===
    [["."]]

s2 =
  IO.inspect(Khf2.szovegelo("khf2_s2.txt")) ===
    [
      ["---", "%%%", "7", "(())", "$$$$", "***", nil, nil, nil, nil],
      ["===", "!!!!!", "\"\"\"\"", "'''", nil, nil, nil, nil, nil, nil],
      ["..", "??", "@@", "&&", "##", "<<", "...", ">>", "bla", "BlaBla"]
    ]

s3 =
  IO.inspect(Khf2.szovegelo("khf2_s3.txt")) ===
    [["itt", "a", "vége", ":", "fuss", "el", "véle!"]]

s4 =
  IO.inspect(Khf2.szovegelo("khf2_s4.txt")) ===
    [
      ["Lakott", "egy", "kisbaba", "Vácott,", nil],
      ["folyton", "a", "macskával", "játszott.", nil],
      ["Kapott", "egy", "plüsst:", nil, nil],
      ["\"Inkább", "ezt", "üsd!\"", nil, nil],
      ["Azt", "hitték,", "arra", "majd", "átszok..."]
    ]

t1 =
  IO.inspect(Khf2.szovegelo("khf2_t1.txt")) ===
    elem(File.read!("khf2_m1.txt") |> Code.eval_string(), 0)

t2 =
  IO.inspect(Khf2.szovegelo("khf2_t2.txt")) ===
    elem(File.read!("khf2_m2.txt") |> Code.eval_string(), 0)

t3 =
  IO.inspect(Khf2.szovegelo("khf2_t3.txt")) ===
    elem(File.read!("khf2_m3.txt") |> Code.eval_string(), 0)

IO.puts("#{s0}, #{s1}, #{s2}, #{s3}, #{s4}")
IO.puts("#{t1}, #{t2}, #{t3}")
