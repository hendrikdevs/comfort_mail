defmodule ComfortMailWeb.ContactLive.Index do
  @moduledoc false
  use ComfortMailWeb, :live_view

  alias ComfortMail.Mails
  alias ComfortMail.Mails.Contact

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :contacts, list_contacts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contact")
    |> assign(:contact, Mails.get_contact!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contact")
    |> assign(:contact, %Contact{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contacts")
    |> assign(:contact, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    contact = Mails.get_contact!(id)
    {:ok, _} = Mails.delete_contact(contact)

    {:noreply, assign(socket, :contacts, list_contacts())}
  end

  defp list_contacts do
    Mails.list_contacts()
  end
end
