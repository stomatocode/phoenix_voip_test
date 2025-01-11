defmodule PhoenixVoipTestWeb.UserController do
  use PhoenixVoipTestWeb, :controller

  alias PhoenixVoipTest.Accounts
  alias PhoenixVoipTest.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.User.changeset(%User{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
