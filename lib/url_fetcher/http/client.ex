defmodule UrlFetcher.Http.Client do
  alias UrlFetcher.Http.{Adapter, Response}
  @behaviour Adapter

  @doc """
    Implementation of the Adapter to HTTPoison
  """
  @impl Adapter
  def get(url) do
    case HTTPoison.get(url) do
      {:ok, response} -> get_successful_response(response)
      {:error, error} -> get_error_response(error)
    end
  end

  @spec get_successful_response(response :: %HTTPoison.Response{}) :: %Response{}
  defp get_successful_response(response) do
    {:ok,
     %Response{
       body: response.body,
       headers: response.headers,
       status_code: response.status_code
     }}
  end

  @spec get_error_response(%HTTPoison.Error{}) :: {:error, atom()}
  def get_error_response(error) do
    {:error, error.reason}
  end
end
