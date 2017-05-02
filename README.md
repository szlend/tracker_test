# TrackerTest - How to reproduce

## Node 1
iex --sname n1 --cookie test -S mix

```elixir
for n <- 1..51, do: Phoenix.Tracker.track(TrackerTest.Tracker, self(), "test", "#{inspect Node.self()}_#{n}", %{})
```

## Node 2
iex --sname n2 --cookie test -S mix

```elixir
for n <- 1..51, do: Phoenix.Tracker.track(TrackerTest.Tracker, self(), "test", "#{inspect Node.self()}_#{n}", %{})

Node.connect :"n1@your_hostname"

```

## Both

Wait a while for Phoenix.Tracker to do it's thing

```elixir
Phoenix.Tracker.list(TrackerTest.Tracker, "test") |> Enum.count

# Node 1
> 51

# Node 2
> 102
```

If you change N from 51 to 50, it works fine, and you get

> falling back to sending entire crdt

instead of 

> sending delta generation 1
