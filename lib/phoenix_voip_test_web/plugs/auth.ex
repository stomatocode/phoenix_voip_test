defmodule PhoenixVoipTestWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias PhoenixVoipTest.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    if user_id = get_session(conn, :user_id) do
      user = Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: ~p"/login")
      |> halt()
    end
  end
end
