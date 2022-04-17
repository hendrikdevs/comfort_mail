defmodule ComfortMail.Mails.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  alias EctoCommons.EmailValidator

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contacts" do
    field :email, :string

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
end
