defmodule ComfortMail.Mails.ContactNotifier do
  import Swoosh.Email

  alias ComfortMail.Mailer
  alias ComfortMail.Mails.Contact

  @company_name "ComfortMail"
  @system_mail "no-reply@comfort-mail.com"

  def deliver_welcome(contact = %Contact{}) do
    new()
    |> to({"Dear User", contact.email})
    |> from({@company_name, @system_mail})
    |> subject("Welcome to #{@company_name}!")
    |> html_body(html_body_welcome(contact.id))
    |> text_body(text_body_welcome(contact.id))
    |> Mailer.deliver()
  end

  defp html_body_welcome(contact_id) do
    "
    <h1>Thank you for registering on comfort-mail.com</h1>
    <p>To complete the registration click on the confirmation link below:</p>
    <a href='https://comfort-mail.com/register/#{contact_id}'>https://comfort-mail.com/register/#{contact_id}</a>
    <p>If you did not sign up using our service, you can safely ignore this email!</p>
    "
  end

  defp text_body_welcome(contact_id) do
    "
    Thank you for registering on comfort-mail.com\n
    To complete the registration click on the confirmation link below:\n
    https://comfort-mail.com/register/#{contact_id}\n\n
    If you did not sign up using our service, you can safely ignore this email!
    "
  end

  def deliver_unregister(%{name: name, email: email}) do
    new()
    |> to({name, email})
    |> from({@company_name, @system_mail})
    |> subject("Welcome to Phoenix, #{name}!")
    |> html_body("<h1>Hello, #{name}</h1>")
    |> text_body("Hello, #{name}\n")
    |> Mailer.deliver()
  end

  def deliver_form_submission(email, %{} = form_content) do
    new()
    |> to({"Dear User", email})
    |> from({@company_name, @system_mail})
    |> subject("A user submitted a form - #{@company_name}")
    |> html_body(html_body_form_submission(form_content))
    |> text_body(text_body_form_submission(form_content))
    |> Mailer.deliver()
  end

  defp html_body_form_submission(form_content = %{}) do
    Enum.reduce(form_content, "", fn ({k, v}, acc) ->
      acc <> "<h2>#{k}</h2><p>#{inspect(v)}</p>\n"
    end)
  end

  defp text_body_form_submission(form_content = %{}) do
    Enum.reduce(form_content, "", fn ({k, v}, acc) ->
      acc <> "#{k}\n  #{inspect(v)}\n\n"
    end)
  end
end
