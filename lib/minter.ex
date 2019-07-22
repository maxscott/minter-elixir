defmodule Minter do
  use GRPC.Server, service: We.Id2.Tokenmint.TokenMint.Service

  # shorten references elsewhere
  alias We.Id2.Tokenmint.{
    MintRefreshTokenRequest,
    MintRefreshTokenResponse,
    MintAccessTokenRequest,
    MintAccessTokenResponse,
    MintActionTokenRequest,
    MintActionTokenResponse,
    GetTokenInfoRequest,
    GetTokenInfoResponse,
    RevokeRefreshTokenRequest
  }

  alias GRPC.Server.Stream

  @spec mint_refresh_token(MintRefreshTokenRequest.t(), Stream.t()) :: MintRefreshTokenResponse.t()
  def mint_refresh_token(%MintRefreshTokenRequest{principal_uuid: principal_uuid}, _stream) do
    case principal_uuid |> MintRefreshTokenHandler.handle() do
      {:ok, data} ->
        MintRefreshTokenResponse.new(data)

      {:error, err} ->
        raise GRPC.RPCError.new(err)
    end
  end

  @spec mint_access_token(MintAccessTokenRequest.t(), Stream.t()) :: MintAccessTokenResponse.t()
  def mint_access_token(%MintAccessTokenRequest{refresh_token: _refresh_token}, _stream) do
    raise GRPC.RPCError.new(:unimplemented)
  end

  @spec mint_action_token(MintActionTokenRequest.t(), Stream.t()) :: MintActionTokenResponse.t()
  def mint_action_token(%MintActionTokenRequest{access_token: _access_token}, _stream) do
    raise GRPC.RPCError.new(:unimplemented)
  end

  @spec get_token_info(GetTokenInfoRequest.t(), Stream.t()) :: GetTokenInfoResponse.t()
  def get_token_info(%GetTokenInfoRequest{token: _token}, _stream) do
    raise GRPC.RPCError.new(:unimplemented)
  end

  @spec revoke_refresh_token(RevokeRefreshTokenRequest.t(), Stream.t()) :: Google.Protobuf.Empty
  def revoke_refresh_token(%RevokeRefreshTokenRequest{token_ref: _token_ref}, _stream) do
    raise GRPC.RPCError.new(:unimplemented)
  end
end
