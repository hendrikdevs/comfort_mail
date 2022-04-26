defmodule ComfortMail.Mails.Contact do
  use Ecto.Schema
  require Logger

  import Ecto.Changeset

  alias EctoCommons.EmailValidator

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contacts" do
    field :email, :string
    field :status, Ecto.Enum, values: [:registered, :activated, :banned]

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> EmailValidator.validate_email(:email)
    |> unique_constraint(:email)
  end

  @doc false
  def registration_changeset(contact, attrs) do
    contact
    |> changeset(attrs)
    |> put_change(:status, :registered)
  end

  @doc false
  def activation_changeset(%{status: :registered} = contact, _attrs) do
    Logger.debug("Activating a contact, id: #{contact.id}")
    change(contact, %{status: :activated})
  end

  @doc false
  def activation_changeset(contact, _attrs) do
    Logger.debug("Contact id: #{contact.id} wanted to activate but could not.")
    contact
    |> change()  # Convert the contact struct to a Ecto.Changeset
    |> add_error(:status, "Contact needs to be in registered state!")
  end
end
