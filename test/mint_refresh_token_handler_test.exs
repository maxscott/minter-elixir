defmodule MintRefreshTokenHandlerTest do
  use ExUnit.Case

  @access_type 2

  describe "handle" do
    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(MinterRepo)
    end

    test "should generate refresh token with valid principal id" do
      sample_date = DateTime.from_naive!(~N[2016-05-24 13:26:08.003], "Etc/UTC")
      sample_principal_id = "245a9777-7add-4e5d-aa2a-f9a863840ade" |> Ecto.UUID.cast!()
      sample_token_id = "da5c3f51-95bc-4961-a158-767e2647b945" |> Ecto.UUID.cast!()

      MinterRepo.insert!(%MinterToken{
        token_id: sample_token_id,
        issued_at: sample_date,
        principal_id: sample_principal_id,
        token_type: @access_type
      })

      issue_at = DateTime.from_naive!(~N[2018-05-23 23:00:00.000], "Etc/UTC")
      create_token_id = "caaaaaaa-95bc-4961-a158-767e2647b945" |> Ecto.UUID.cast!()
      signature = "232ewklfjlkj243tlkjg"

      assumed_token =
        "Ck4KJGNhYWFhYWFhLTk1YmMtNDk2MS1hMTU4LTc2N2UyNjQ3Yjk0NRIkMjQ1YTk3NzctN2FkZC00ZTVkLWFhMmEtZjlhODYzODQwYWRlGAESFDIzMmV3a2xmamxrajI0M3Rsa2pn"

      {:ok, %{refresh_token: refresh_token}} =
        MintRefreshTokenHandler.handle(
          sample_principal_id,
          signature,
          issue_at,
          create_token_id
        )

      assert assumed_token == refresh_token
    end
  end
end
