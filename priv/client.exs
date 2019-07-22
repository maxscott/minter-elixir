alias We.Id2.Tokenmint.MintRefreshTokenRequest
alias We.Id2.Tokenmint.TokenMint

principal_id = "245a9777-7add-4e5d-aa2a-f9a863840ade" |> Ecto.UUID.cast!()

token = MinterRepo.insert!(%MinterToken{
  principal_id: principal_id,
  issued_at: DateTime.from_naive!(~N[2016-05-24 13:26:08.003], "Etc/UTC"),
  token_type: 2 # access type
})

{:ok, channel} = GRPC.Stub.connect("localhost:50051")

IO.puts "\nSend a good request"
req = MintRefreshTokenRequest.new(principal_uuid: principal_id)
channel |> TokenMint.Stub.mint_refresh_token(req) |> IO.inspect()

IO.puts "\nSend a bad request"
req = MintRefreshTokenRequest.new(principal_uuid: Ecto.UUID.generate())
channel |> TokenMint.Stub.mint_refresh_token(req) |> IO.inspect()

MinterRepo.delete_all MinterToken
