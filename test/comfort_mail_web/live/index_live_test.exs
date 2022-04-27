defmodule ComfortMailWeb.IndexLiveTest do
  use ComfortMailWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "homepage shows ComfortMail Information", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.index_index_path(conn, :index))

      assert html =~ "ComfortMail"
    end

    test "homepage shows registration form", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.index_index_path(conn, :index))

      assert html =~ "Register"
    end

    test "allows the register with a valid email address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.index_index_path(conn, :index))

      {:ok, _index_live, html} =
        index_live
        |> form("#contact-register-form", contact: %{email: "test@test.com"})
        |> render_submit()
        |> follow_redirect(conn, Routes.index_index_path(conn, :index))

      assert html =~ "Registered successfully"
    end

    test "does not register with invalid email address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.index_index_path(conn, :index))

      assert index_live
      |> form("#contact-register-form", contact: %{email: "invalid"})
      |> render_submit() =~ "is not a valid email"
    end
  end
end
