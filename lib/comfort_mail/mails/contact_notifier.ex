defmodule ComfortMail.Mails.ContactNotifier do
  import Swoosh.Email
  alias ComfortMail.Mailer

  @company_name "ComfortMail"
  @system_mail "no-reply@comfort-mail.com"

  def deliver_welcome(%{name: name, email: email}) do
    new()
    |> to({name, email})
    |> from({@company_name, @system_mail})
    |> subject("Welcome to Comfort, #{name}!")
    |> html_body("<h1>Hello, #{name}</h1>")
    |> text_body("Hello, #{name}\n")
    |> Mailer.deliver()
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

  def deliver_form_submission(email, form_content = %{}) do
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
