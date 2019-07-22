defmodule MinterTest do
  use ExUnit.Case

  alias We.Id2.Tokenmint.{MintRefreshTokenRequest, MintRefreshTokenResponse}

  @access_type 2

  describe "MintRefreshToken" do
    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(MinterRepo)
    end

    test "responds to request with response" do
      sample_access_token =
        MinterRepo.insert!(%MinterToken{
          issued_at: DateTime.utc_now(),
          principal_id: Ecto.UUID.generate(),
          token_type: @access_type
        })

      req = MintRefreshTokenRequest.new(principal_uuid: sample_access_token.principal_id)
      res = Minter.mint_refresh_token(req, nil)

      assert res.__struct__ == MintRefreshTokenResponse
    end
  end
end
