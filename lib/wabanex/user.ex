defmodule Wabanex.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.Training

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :password, :name]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    has_one :training, Training

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields) #valida se todos os campos estão preenchidos
    |> validate_length(:password, min: 6) #valida se a senha tem no min 6 caracteres
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/) #bem simples p ver se um email eh um email
    |> unique_constraint([:email]) #ve se n já tem um email igual
  end
end
