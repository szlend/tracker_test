defmodule TrackerTest.Tracker do
  @behaviour Phoenix.Tracker

  def start_link(opts) do
    opts = Keyword.merge([name: __MODULE__], opts)
    GenServer.start_link(Phoenix.Tracker, [__MODULE__, opts, opts], name: __MODULE__)
  end

  def init(opts) do
    server = Keyword.fetch!(opts, :pubsub_server)
    {:ok, %{pubsub_server: server, node_name: Phoenix.PubSub.node_name(server)}}
  end

  def handle_diff(diff, state) do
    for {topic, {joins, leaves}} <- diff do
      for {key, _meta} <- joins do
        IO.puts("JOIN #{key} ON #{topic}")
      end
      for {key, _meta} <- leaves do
        IO.puts("JOIN #{key} ON #{topic}")
      end
    end
    {:ok, state}
  end
end
