defmodule ComfortMailWeb.SubmitControllerTest do
  use ComfortMailWeb.ConnCase

  # test "GET /", %{conn: conn} do
  #   conn = get(conn, "/")
  #   assert html_response(conn, 200) =~ "ComfortMail"
  # end

  describe "submit form" do
    alias ComfortMail.Mails

    import ComfortMail.MailsFixtures

    @valid_data %{"email" => "user@submitted.form", "subject" => "important request"}

    test "redirects to show when the submission was valid", %{conn: conn} do
      contact = contact_fixture()
      {:ok, contact} = Mails.activate_contact(contact)

      conn = post(conn, Routes.submit_path(conn, :submit, contact.email), post: @valid_data)
      assert redirected_to(conn) == Routes.submit_path(conn, :success)
    end

    test "redirects to show error when account was not activated", %{conn: conn} do
      contact = contact_fixture()

      conn = post(conn, Routes.submit_path(conn, :submit, contact.email), post: @valid_data)
      assert redirected_to(conn, 400) == Routes.submit_path(conn, :failure)
    end

    test "redirects to show error when for the give id no contact exists", %{conn: conn} do
      conn = post(conn, Routes.submit_path(conn, :submit, "no@email.com"), post: @valid_data)
      assert redirected_to(conn, 400) == Routes.submit_path(conn, :failure)
    end
  end

  test "success/2 shows a success message to the user", %{conn: conn} do
    conn = get(conn, Routes.submit_path(conn, :success))
    assert html_response(conn, 200) =~ "successfully"
  end

  test "failure/2 shows a failure message to the user", %{conn: conn} do
    conn = get(conn, Routes.submit_path(conn, :failure))
    assert html_response(conn, 200) =~ "not submitted"
  end
end
