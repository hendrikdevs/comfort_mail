defmodule ComfortMail.MailsTest do
  use ComfortMail.DataCase

  alias ComfortMail.Mails

  describe "contacts" do
    alias ComfortMail.Mails.Contact

    import ComfortMail.MailsFixtures

    @invalid_attrs %{email: nil}

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Mails.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Mails.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      valid_attrs = %{email: "some@email.com"}

      assert {:ok, %Contact{} = contact} = Mails.create_contact(valid_attrs)
      assert contact.email == "some@email.com"
      assert contact.status == :registered
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mails.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      update_attrs = %{email: "some@updated.email"}

      assert {:ok, %Contact{} = contact} = Mails.update_contact(contact, update_attrs)
      assert contact.email == "some@updated.email"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Mails.update_contact(contact, @invalid_attrs)
      assert contact == Mails.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Mails.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Mails.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Mails.change_contact(contact)
    end

    test "activate_contact/2 returns a contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Mails.activate_contact(contact)
    end

    test "activate_contact/2 returns a contact with an activated status" do
      contact = contact_fixture()
      {:ok, contact} = Mails.activate_contact(contact)
      assert :activated = contact.status
    end

    test "activate_contact/2 return a contant changeset when not using a contact in a registered status" do
      contact = contact_fixture()
      {:ok, contact} = Mails.activate_contact(contact)

      assert {:error, %Ecto.Changeset{}} = Mails.activate_contact(contact)
    end
  end
end
