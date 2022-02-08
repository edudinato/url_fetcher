defmodule UrlFetcher.Http.Adapter do
  alias UrlFetcher.Http.Response

  @callback get(url :: String.t()) :: {:ok, %Response{ status_code: integer()}}
  @callback get(url :: String.t()) :: {:error, atom()}
end
