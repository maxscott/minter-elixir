defmodule MinterRepo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens, primary_key: false) do
      add :token_id, :uuid, primary_key: true
      add :token_type, :integer
      add :issued_at, :naive_datetime, null: false
      add :revoked, :boolean
      add :principal_id, :uuid
    end
  end
end
