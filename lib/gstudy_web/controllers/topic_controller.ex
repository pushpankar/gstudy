defmodule GstudyWeb.TopicController do
    use GstudyWeb, :controller
    

    alias Gstudy.Frameworks
    alias Gstudy.Frameworks.{Topic, Link, Framework}

    def index(conn, _params) do
    end

    def new(conn, %{"framework_id" => framework_id}) do
        changeset = 
            Frameworks.change_topic(%Topic{})
            |> Ecto.Changeset.put_assoc(:links, [Frameworks.change_link(%Link{})])
        render(conn, "new.html", changeset: changeset, framework_id: framework_id)
    end

    def show(conn, _params) do
    end

    def create(conn, %{"topic" => topic_params, "framework_id" => framework_id}) do
        framework_old = Frameworks.get_framework!(framework_id)
        framework_new = Map.replace!(framework_old, :topics, framework_old.topics ++ [topic_params]) |> Map.from_struct()

        case Frameworks.update_framework(framework_old, framework_new) do
            {:ok, framework} ->
                conn
                |> put_flash(:info, "Succcess")
                |> redirect(to: framework_path(conn, :show, framework))
            {:error, changeset} ->
                conn
                |> put_flash(:info, "Error")
        end
    end

end