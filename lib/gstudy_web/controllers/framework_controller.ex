defmodule GstudyWeb.FrameworkController do
  use GstudyWeb, :controller

  alias Gstudy.Frameworks
  alias Gstudy.Frameworks.{Framework, Topic, Link}

  def index(conn, _params) do
    frameworks = Frameworks.list_frameworks()
    render(conn, "index.html", frameworks: frameworks)
  end

  def new(conn, _params) do
    changeset = Frameworks.change_framework(%Framework{})
    render(conn, "new.html", changeset: changeset)
  end
  
 ########################################
 ########### Refactor it ################
 ########################################

  defp parse_topic(topic) do
    Enum.map(topic, fn x -> %{links: Map.values(x["links"]), name: x["name"]} end )
  end

  def create(conn, %{"framework" => framework_params}) do
    case Frameworks.create_framework(framework_params) do
      {:ok, %{id: framework_id}} ->
        conn
        |> put_flash(:info, "Now add topics to the framework.")
        |> redirect(to: framework_topic_path(conn, :new, framework_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    framework = Frameworks.get_framework!(id)
    render(conn, "show.html", framework: framework)
  end

  def edit(conn, %{"id" => id}) do
    framework = Frameworks.get_framework!(id)
    changeset = Frameworks.change_framework(framework)
    render(conn, "edit.html", framework: framework, changeset: changeset)
  end

  def update(conn, %{"id" => id, "framework" => framework_params}) do
    framework = Frameworks.get_framework!(id)

    case Frameworks.update_framework(framework, framework_params) do
      {:ok, framework} ->
        conn
        |> put_flash(:info, "Framework updated successfully.")
        |> redirect(to: framework_path(conn, :show, framework))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", framework: framework, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    framework = Frameworks.get_framework!(id)
    {:ok, _framework} = Frameworks.delete_framework(framework)

    conn
    |> put_flash(:info, "Framework deleted successfully.")
    |> redirect(to: framework_path(conn, :index))
  end
end
