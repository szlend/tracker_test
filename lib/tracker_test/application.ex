defmodule TrackerTest.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Phoenix.PubSub.PG2, [TrackerTest.PubSub, []]),
      worker(TrackerTest.Tracker, [[name: TrackerTest.Tracker, pubsub_server: TrackerTest.PubSub]]),
    ]

    opts = [strategy: :one_for_one, name: TrackerTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
