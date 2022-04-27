defmodule ComfortMailWeb.IndexLive.Index do
  @moduledoc false

  use ComfortMailWeb, :live_view

  alias ComfortMail.Mails.Contact

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:contact, %Contact{})}
  end
end
