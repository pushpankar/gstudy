defmodule GstudyWeb.TopicController do
    use GstudyWeb, :controller

    alias Gstudy.Frameworks
    alias Gstudy.Frameworks.{Topic, Link}

    plug :assign_framework

    def index(conn, _params) do

    end

    def new(conn, %{"framework_id" => framework_id}) do
        changeset = Frameworks.change_topic(%Topic{links: [%Topic{}]})
        render(conn, "new.html", changeset: changeset, framework_id: framework_id)
    end

    def show(conn, _params) do

    end

    def create(conn, %{"topic" => topic_params}) do
        case Frameworks.create_topic(topic_params) do
            {:ok, topic} ->
                conn
                |> put_flash(:info, "Do you want to add more topics")
            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def assign_framework(conn, _opts) do
        case conn.params do
            %{"framework_id" => framework_id} ->
                framework = Frameworks.get_topic(framework_id)
                assign(conn, :framework, framework)
            _ ->
                conn
        end
    end
end