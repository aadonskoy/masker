# Masker

It check where is the 2d pattern included in a 2d array:

Ex:

```
pattern = [
  [:O, :X, :O],
  [:O, :X, :O],
  [:X, :X, :X]
]

array2d = [
  [1, 4, 2, 4, 5],
  [1, 5, 1, 5, 4],
  [4, 5, 1, 5, 8],
  [8, 1, 1, 1, 4],
  [5, 1, 2, 4, 1]
]

Masker.has_pattern?(pattern, array2d)
> {:ok, [%{col: 1, row: 1}]}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `masker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:masker, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/masker](https://hexdocs.pm/masker).

