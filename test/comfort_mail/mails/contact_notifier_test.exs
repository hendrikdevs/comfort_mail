defmodule ComfortMail.Mails.ContactNotifierTest do
  use ExUnit.Case, async: true
  import Swoosh.TestAssertions

  alias ComfortMail.Mails.ContactNotifier

  test "deliver_welcome/1" do
    user = %{name: "Alice", email: "alice@example.com"}

    ContactNotifier.deliver_welcome(user)

    assert_email_sent(
      subject: "Welcome to Phoenix, Alice!",
      to: {"Alice", "alice@example.com"},
      text_body: ~r/Hello, Alice/
    )
  end

  test "deliver_unregister/1" do
    user = %{name: "Alice", email: "alice@example.com"}

    ContactNotifier.deliver_unregister(user)

    assert_email_sent(
      subject: "Welcome to Phoenix, Alice!",
      to: {"Alice", "alice@example.com"},
      text_body: ~r/Hello, Alice/
    )
  end

  test "deliver_form_submission/1" do
    user = %{name: "Alice", email: "alice@example.com"}
    content = %{email: "test@test.com", subject: "Question about the product"}

    ContactNotifier.deliver_form_submission(user.email, content)

    assert_email_sent(
      subject: "A user submitted a form - ComfortMail",
      to: {"Dear User", "alice@example.com"},
      text_body: ~r/email/
    )
  end
end
