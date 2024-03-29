defmodule ComfortMailWeb.IndexLive.RegisterForm do
  @moduledoc false

  use ComfortMailWeb, :live_component

  alias ComfortMail.Mails
  alias ComfortMail.Mails.ContactNotifier

  @impl true
  def update(%{contact: contact} = assigns, socket) do
    changeset = Mails.change_contact(contact)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"contact" => contact_params}, socket) do
    changeset =
      socket.assigns.contact
      |> Mails.change_contact(contact_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("register", %{"contact" => contact_params}, socket) do
    save_contact(socket, :new, contact_params)
  end

  defp save_contact(socket, :new, contact_params) do
    case Mails.create_contact(contact_params) do
      {:ok, contact} ->
        ContactNotifier.deliver_welcome(contact)

        {:noreply,
         socket
         |> put_flash(
           :info,
           "Registered successfully - You will receive a confirmation link soon!"
         )
         |> push_redirect(to: "/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
