defmodule ComfortMailWeb.SubmitController do
  use ComfortMailWeb, :controller
  require Logger

  alias ComfortMail.Mails

  def submit(%Plug.Conn{body_params: body_params, path_params: path_params} = conn, _params) do
    # Get the contact email
    email = path_params["email"]

    # Get the contact
    case Mails.get_contact_by_email(email) do
      nil ->
        Logger.info("Form for email: #{email} got submitted, but no contact with that email exists.")

        # confirm bad request - redirect to failure page
        conn
        |> put_status(400)
        |> redirect(to: Routes.submit_path(conn, :failure))

      contact ->
        case Mails.submit_content_to_contact(contact, body_params) do
          {:ok, _contact} ->
            conn
            |> put_status(302)
            |> redirect(to: Routes.submit_path(conn, :success))

          _ ->
            conn
          |> put_status(400)
          |> redirect(to: Routes.submit_path(conn, :failure))
        end
    end
  end

  def success(conn, _params) do
    render(conn, "success.html")
  end

  def failure(conn, _params) do
    render(conn, "failure.html")
  end
end
