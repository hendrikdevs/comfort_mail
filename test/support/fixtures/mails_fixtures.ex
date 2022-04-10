defmodule ComfortMail.MailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ComfortMail.Mails` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        email: "some email"
      })
      |> ComfortMail.Mails.create_contact()

    contact
  end
end
