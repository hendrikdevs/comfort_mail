defmodule ComfortMailWeb.RegistrationController do
  use ComfortMailWeb, :controller
  require Logger

  alias ComfortMail.Mails
  alias ComfortMail.Mails.Contact

  def activate(conn, %{"id" => id}) do
    try do
      contact = Mails.get_contact!(id)
      Logger.debug("Got contact: #{inspect(contact)}")

      case Mails.activate_contact(contact) do
        {:ok, %Contact{}} ->
          conn
          |> put_status(200)
          |> render("activated.html")

        {:error, _changeset} ->
          conn
          |> put_status(400)
          |> render("activation_failed.html")
      end

    rescue
      _ ->
        conn
        |> put_status(400)
        |> render("activation_failed.html")
    end


  end
end
