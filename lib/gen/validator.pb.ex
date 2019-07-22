defmodule Validator.FieldValidator do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          regex: String.t(),
          int_gt: integer,
          int_lt: integer,
          msg_exists: boolean,
          human_error: String.t(),
          float_gt: float,
          float_lt: float,
          float_epsilon: float,
          float_gte: float,
          float_lte: float,
          string_not_empty: boolean,
          repeated_count_min: integer,
          repeated_count_max: integer,
          length_gt: integer,
          length_lt: integer,
          length_eq: integer
        }
  defstruct [
    :regex,
    :int_gt,
    :int_lt,
    :msg_exists,
    :human_error,
    :float_gt,
    :float_lt,
    :float_epsilon,
    :float_gte,
    :float_lte,
    :string_not_empty,
    :repeated_count_min,
    :repeated_count_max,
    :length_gt,
    :length_lt,
    :length_eq
  ]

  field(:regex, 1, optional: true, type: :string)
  field(:int_gt, 2, optional: true, type: :int64)
  field(:int_lt, 3, optional: true, type: :int64)
  field(:msg_exists, 4, optional: true, type: :bool)
  field(:human_error, 5, optional: true, type: :string)
  field(:float_gt, 6, optional: true, type: :double)
  field(:float_lt, 7, optional: true, type: :double)
  field(:float_epsilon, 8, optional: true, type: :double)
  field(:float_gte, 9, optional: true, type: :double)
  field(:float_lte, 10, optional: true, type: :double)
  field(:string_not_empty, 11, optional: true, type: :bool)
  field(:repeated_count_min, 12, optional: true, type: :int64)
  field(:repeated_count_max, 13, optional: true, type: :int64)
  field(:length_gt, 14, optional: true, type: :int64)
  field(:length_lt, 15, optional: true, type: :int64)
  field(:length_eq, 16, optional: true, type: :int64)
end
