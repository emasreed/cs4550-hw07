defmodule EventsHwWeb.Helpers do


  def have_current_user?(conn) do
    conn.assigns[:current_user] != nil
  end

  def current_user_id?(conn, user_id) do
    user = conn.assigns[:current_user]
    user && user.id == user_id
  end

  def invited?(conn, event_id, user_id) do
    if current_user_id?(conn, user_id) do
      true
    else
      if have_current_user?(conn) do
        user = conn.assigns[:current_user]
        EventsHw.Invites.is_invited(event_id, user.id)
      else
        false
      end
    end
  end
end
