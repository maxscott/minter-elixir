defmodule MinterApp do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      MinterRepo,
      {GRPC.Server.Supervisor, {Minter, 50051}}
    ]

    opts = [strategy: :one_for_one, name: MinterApp]
    Supervisor.start_link(children, opts)
  end
end
