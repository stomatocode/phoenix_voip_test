defmodule PhoenixVoipTest.Accounts do
  import Ecto.Query
  alias PhoenixVoipTest.Repo
  alias PhoenixVoipTest.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
end
