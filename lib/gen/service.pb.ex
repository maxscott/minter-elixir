defmodule We.Id2.Tokenmint.MintRefreshTokenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          principal_uuid: String.t()
        }
  defstruct [:principal_uuid]

  field(:principal_uuid, 1, type: :bytes)
end

defmodule We.Id2.Tokenmint.MintRefreshTokenResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          refresh_token: String.t()
        }
  defstruct [:refresh_token]

  field(:refresh_token, 1, type: :string)
end

defmodule We.Id2.Tokenmint.MintAccessTokenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          refresh_token: String.t()
        }
  defstruct [:refresh_token]

  field(:refresh_token, 1, type: :string)
end

defmodule We.Id2.Tokenmint.MintAccessTokenResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          access_token: String.t()
        }
  defstruct [:access_token]

  field(:access_token, 1, type: :string)
end

defmodule We.Id2.Tokenmint.MintActionTokenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          access_token: String.t()
        }
  defstruct [:access_token]

  field(:access_token, 1, type: :string)
end

defmodule We.Id2.Tokenmint.MintActionTokenResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          action_token: String.t()
        }
  defstruct [:action_token]

  field(:action_token, 1, type: :string)
end

defmodule We.Id2.Tokenmint.GetTokenInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          token: String.t()
        }
  defstruct [:token]

  field(:token, 1, type: :string)
end

defmodule We.Id2.Tokenmint.GetTokenInfoResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          token_uuid: String.t(),
          type: integer,
          valid: boolean,
          issued_at: integer,
          expires_at: integer,
          principal_uuid: String.t()
        }
  defstruct [:token_uuid, :type, :valid, :issued_at, :expires_at, :principal_uuid]

  field(:token_uuid, 1, type: :bytes)
  field(:type, 2, type: We.Id2.Tokenmint.GetTokenInfoResponse.TokenType, enum: true)
  field(:valid, 3, type: :bool)
  field(:issued_at, 4, type: :int64)
  field(:expires_at, 5, type: :int64)
  field(:principal_uuid, 6, type: :bytes)
end

defmodule We.Id2.Tokenmint.GetTokenInfoResponse.TokenType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field(:UNKNOWN, 0)
  field(:OAUTH2_REFRESH, 1)
  field(:OAUTH2_ACCESS, 2)
  field(:ACTION, 3)
end

defmodule We.Id2.Tokenmint.RevokeRefreshTokenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          token_ref: {atom, any}
        }
  defstruct [:token_ref]

  oneof(:token_ref, 0)
  field(:token_uuid, 1, type: :bytes, oneof: 0)
  field(:token, 2, type: :string, oneof: 0)
end

defmodule We.Id2.Tokenmint.TokenMint.Service do
  @moduledoc false
  use GRPC.Service, name: "we.id2.tokenmint.TokenMint"

  rpc(
    :MintRefreshToken,
    We.Id2.Tokenmint.MintRefreshTokenRequest,
    We.Id2.Tokenmint.MintRefreshTokenResponse
  )

  rpc(
    :MintAccessToken,
    We.Id2.Tokenmint.MintAccessTokenRequest,
    We.Id2.Tokenmint.MintAccessTokenResponse
  )

  rpc(
    :MintActionToken,
    We.Id2.Tokenmint.MintActionTokenRequest,
    We.Id2.Tokenmint.MintActionTokenResponse
  )

  rpc(:GetTokenInfo, We.Id2.Tokenmint.GetTokenInfoRequest, We.Id2.Tokenmint.GetTokenInfoResponse)
  rpc(:RevokeRefreshToken, We.Id2.Tokenmint.RevokeRefreshTokenRequest, Google.Protobuf.Empty)
end

defmodule We.Id2.Tokenmint.TokenMint.Stub do
  @moduledoc false
  use GRPC.Stub, service: We.Id2.Tokenmint.TokenMint.Service
end
