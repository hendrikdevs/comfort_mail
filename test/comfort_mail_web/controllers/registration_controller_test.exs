defmodule ComfortMailWeb.RegistrationControllerTest do
  use ComfortMailWeb.ConnCase

  describe "activate/2" do
    alias ComfortMail.Mails

    import ComfortMail.MailsFixtures

    test "activates a registered account", %{conn: conn} do
      contact = contact_fixture()

      conn = get(conn, Routes.registration_path(conn, :activate, contact.id))
      assert html_response(conn, 200) =~ "activated"
    end

    test "does not activate a contact that does not exists", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :activate, "1234567890"))
      assert html_response(conn, 400) =~ "failed"
    end

    test "does not activate a activated contact", %{conn: conn} do
      contact = contact_fixture()
      {:ok, contact} = Mails.activate_contact(contact)

      conn = get(conn, Routes.registration_path(conn, :activate, contact.id))
      assert html_response(conn, 400) =~ "failed"
    end
  end
end
