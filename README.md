# Token Mint µService - Elixir

Very much a WIP for implementing the specs outlined in the main folder; a gRPC service using the given protobuf definitions and providing the given endpoints.

## Elixir?

Elixir is a compiled, functional, concurrent, general-purpose programming language that runs on the Erlang virtual machine (BEAM). Elixir builds on top of Erlang and shares the same abstractions for building distributed, fault-tolerant applications. Elixir also provides a productive tooling and an extensible design. The latter is supported by compile-time metaprogramming with macros and polymorphism via protocols. ~ Wikipadia

### Who is using it

Erlang is known for powering telecom (3g and LTE) and more recently made waves as the core of WhatsApp and previously Facebook Chat. Elixir is currently known to be powering [Pinterest](https://medium.com/@Pinterest_Engineering/introducing-new-open-source-tools-for-the-elixir-community-2f7bb0bb7d8c), [Discord](https://blog.discordapp.com/scaling-elixir-f9b8e1e7c29b), and [Pager Duty](https://www.pagerduty.com/blog/elixir-at-pagerduty/) amongst others. Looking closer to home, Elixir is powering Flatiron School's web-based IDE, as well as WeWork's new Hot Desk backend.

Features of Elixir inherited from erlang include:
- **Distributed** (OTP apps and distributed storage via mnesia)
- **Fault tolerant** (light-weight processes are siloed and communicate via messages)
- **Soft real-time** (not UDP packet-style fire-and-forget)
- **High availability** (processes "fail-fast" and restart necessary components)
- **Hot swapping** (can deploy to nodes without taking them down)

Elixir features:
- **Piping** `getValues() |> useValues()` is equivalent to `useValues(getValues())`, making functional programming natural feeling.
- **Pattern-matching syntax** `{status, [first | rest], %{key: val}} = {:ok, [1,2,3], %{key: "Hello"}}` binds status=:ok, first=1, rest=[2,3], val="Hello"
- **Polymorphism** via protocols & behaviors

## Setup

Elixir and Mix (rake-like tool) Setup

```bash
brew install elixir
```

Dependency/database setup (postgres)

```bash
mix deps.get
mix ecto.create
mix ecto.migrate
```

Application commands

```bash
# run all tests
mix test

# run test watcher, recompiles/runs on file changes
mix test.watch

# run grpc server
mix grpc.server

# run test client (which should respond correctly with "bad params" since the token doesn't exist in db yet)
mix run priv/client.exs

# format is elixir's built-in rubocop (.formatter.exs)
mix format

# run static analysis tools (uses @spec, @behavior, and @protocol)
mix dialyzer
```

## Installation

If [available in Hex](https://hex.pm/docs/publish) (_spoiler alert, it's not yet_), the package can be installed
by adding `tokenmint` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [ {:tokenmint, "~> 0.1.0"} ]
end
```

## TODO List 🤔

[.] Implement first endpoint (MintRefreshToken)
[ ] Utilize [json_web_token_ex](https://github.com/garyf/json_web_token_ex) to sign via ECDSA using P-256 and SHA-256 per DSS.
[ ] Implement other endpoints
[ ] Profit

Please reach out with any/all questions/comments/feedback!
