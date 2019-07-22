defmodule MinterToken do
  use Ecto.Schema

  @primary_key {:token_id, :binary_id, autogenerate: true}

  schema "tokens" do
    field(:principal_id, :binary_id)
    field(:token_type, :integer)
    field(:issued_at, :naive_datetime)
    field(:revoked, :boolean)
  end
end
