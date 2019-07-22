defmodule MintRefreshTokenHandler do
  alias We.Id2.Token.Token, as: ProtoToken
  alias We.Id2.Token.SignedData

  @oauth2_refresh_type 1

  def handle(
        principal_id,
        signature \\ "something",
        issue_at \\ DateTime.utc_now(),
        create_token_id \\ Ecto.UUID.generate()
      ) do
    with {:ok, _found_token} <- validate_id(principal_id),
         {:ok, minted_token} <- mint_token(principal_id, issue_at, create_token_id),
         refresh_token <-
           minted_token
           |> encode_token()
           |> sign_encode_data(signature) do
      {:ok, %{refresh_token: refresh_token}}
    end
  end

  defp validate_id(principal_id) do
    case MinterToken |> MinterRepo.get_by(principal_id: principal_id) do
      nil ->
        {:error, :invalid_argument}

      token ->
        {:ok, token}
    end
  end

  defp mint_token(principal_id, issue_at, token_id) do
    %MinterToken{
      token_id: token_id,
      issued_at: issue_at,
      principal_id: principal_id,
      token_type: @oauth2_refresh_type
    }
    |> MinterRepo.insert()
  end

  defp encode_token(minted_token) do
    ProtoToken.new(
      token_uuid: minted_token.token_id,
      principal_uuid: minted_token.principal_id,
      type: minted_token.token_type,
      expires_at: 0
    )
    |> ProtoToken.encode()
  end

  defp sign_encode_data(data, signature) do
    SignedData.new(data: data, signature: signature)
    |> SignedData.encode()
    |> Base.url_encode64()
  end
end
