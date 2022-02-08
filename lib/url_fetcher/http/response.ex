defmodule UrlFetcher.Http.Response do
  defstruct status_code: nil, headers: [], body: ""

  @type t :: %__MODULE__{
    status_code: integer,
    body: term,
    headers: list,
  }
end
