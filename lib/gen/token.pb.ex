defmodule We.Id2.Token.SignedData do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          signature: String.t()
        }
  defstruct [:data, :signature]

  field(:data, 1, type: :bytes)
  field(:signature, 2, type: :bytes)
end

defmodule We.Id2.Token.Token do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          token_uuid: String.t(),
          principal_uuid: String.t(),
          type: integer,
          expires_at: integer
        }
  defstruct [:token_uuid, :principal_uuid, :type, :expires_at]

  field(:token_uuid, 1, type: :bytes)
  field(:principal_uuid, 2, type: :bytes)
  field(:type, 3, type: We.Id2.Token.Token.TokenType, enum: true)
  field(:expires_at, 4, type: :int64)
end

defmodule We.Id2.Token.Token.TokenType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field(:UNKNOWN, 0)
  field(:OAUTH2_REFRESH, 1)
  field(:OAUTH2_ACCESS, 2)
  field(:ACTION, 3)
end
