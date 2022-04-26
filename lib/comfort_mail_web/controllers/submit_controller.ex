defmodule ComfortMailWeb.SubmitController do
  use ComfortMailWeb, :controller
  require Logger

  alias ComfortMail.Mails
  alias ComfortMail.Mails.ContactNotifier

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

      contact ->  # TODO: Create a API function in the Mails context.
        if contact.status != :activated do  # Check that the account is activated
          conn
          |> put_status(400)
          |> redirect(to: Routes.submit_path(conn, :failure))
        end

        ContactNotifier.deliver_form_submission(contact.email, body_params)
        Logger.info("Successfully delivered form submission to: #{contact.email}")

        # confirm post request - redirect to success page
        conn
        |> put_status(200)
        |> redirect(to: Routes.submit_path(conn, :success))
    end
  end

  def success(conn, _params) do
    render(conn, "success.html")
  end

  def failure(conn, _params) do
    render(conn, "failure.html")
  end
end
