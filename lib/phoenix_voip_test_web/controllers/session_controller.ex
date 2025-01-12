defmodule PhoenixVoipTestWeb.SessionController do
  use PhoenixVoipTestWeb, :controller

  alias PhoenixVoipTest.Accounts

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render(:new)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: ~p"/")
  end
end
