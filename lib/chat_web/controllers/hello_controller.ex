defmodule ChatWeb.HelloController do
  use ChatWeb, :controller
  alias Chat.{ Repo, User }

  plug :put_view, text: ChatWeb.HelloText, json: ChatWeb.HelloJSON

  def hello(conn, _params) do
    # json(conn, %{id: "Hello World"})
    # send_resp(conn, 200, "")

    # defining the parameters
    params = %{
      email: "chobisa.henit@gmail.com",
      name: "Henit Chobisa",
      number_of_pets: 3,
      bio: "Nothing much to talk about me."
    }

    # validating the parameters
    change_set = User.changeset(%User{}, params)

    case Repo.insert change_set do
      {:ok, struct} ->
        json(conn, Map.from_struct(struct))
      {:error, changeset} ->
        json(conn, Map.from_struct(changeset))
      _ ->
        send_resp(conn, 400, "Sorry, there is something wrong with the provided params.")
    end

    # Repo.insert(%User{name: "Henit Chobisa", email: "chobisa.henit@gmail.com"})

    # IO.puts data
    # json(conn, %{id: "Hello"})
  end
end
