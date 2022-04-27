defmodule ComfortMailWeb.ContactLive.Show do
  @moduledoc false

  use ComfortMailWeb, :live_view

  alias ComfortMail.Mails

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contact, Mails.get_contact!(id))}
  end

  defp page_title(:show), do: "Show Contact"
  defp page_title(:edit), do: "Edit Contact"
end
