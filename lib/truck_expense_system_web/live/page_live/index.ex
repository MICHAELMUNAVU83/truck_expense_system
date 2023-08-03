defmodule TruckExpenseSystemWeb.PageLive.Index do
  use TruckExpenseSystemWeb, :live_view
  alias TruckExpenseSystem.Users

  def mount(_params, session, socket) do
    if is_nil(session["user_token"]) do
      {:ok,
       socket
       |> assign(:user, nil)}
    else
      user = Users.get_user_by_session_token(session["user_token"])

      {:ok,
       socket
       |> assign(:user, user)}
    end
  end
end
