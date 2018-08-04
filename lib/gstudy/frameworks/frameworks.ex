defmodule Gstudy.Frameworks do
  @moduledoc """
  The Frameworks context.
  """

  import Ecto.Query, warn: false
  alias Gstudy.Repo

  alias Gstudy.Frameworks.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{source: %Link{}}

  """
  def change_link(%Link{} = link) do
    Link.changeset(link, %{})
  end

  alias Gstudy.Frameworks.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Topic
    |> Repo.all()
    |> Repo.preload(:links)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic(id) do
    Topic
    |> Repo.get(id)
    |> Repo.preload(:links)
  end

  def link_to_id(link) do
    link
    |> create_link()
    |> handle_existing_link()
  end

  defp handle_existing_link({:ok, _link} = status), do: status
  defp handle_existing_link({:error, changeset}) do
    { :ok,
      Repo.get_by!(Link, url: changeset.changes.url)
    }
  end

  @doc """
  Creates a topic and its associations
  ## Examples
      @ToDo
  """
  def create_topic(topic, links \\ [%{}]) do
    topic_id = elem(insert_topic(topic), 1).id

    link_ids = Enum.map(links, fn(x) -> elem(link_to_id(x), 1).id end)
    create_topic_maker(topic_id, link_ids)
  end


  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def insert_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end





  alias Gstudy.Frameworks.Topic_maker

  @doc """
  Returns the list of topic_makers.

  ## Examples

      iex> list_topic_makers()
      [%Topic_maker{}, ...]

  """
  def list_topic_makers do
    Repo.all(Topic_maker)
  end

  @doc """
  Gets a single topic_maker.

  Raises `Ecto.NoResultsError` if the Topic maker does not exist.

  ## Examples

      iex> get_topic_maker!(123)
      %Topic_maker{}

      iex> get_topic_maker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic_maker!(id), do: Repo.get!(Topic_maker, id)

  @doc """
  Creates a topic_maker.

  ## Examples

      iex> create_topic_maker(%{field: value})
      {:ok, %Topic_maker{}}

      iex> create_topic_maker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic_maker(_topic_id, []), do: {:ok}
  def create_topic_maker(topic_id, link_ids) do
    add_link_to_topic(%{topic_id: topic_id, link_id: hd(link_ids)})
    create_topic_maker(topic_id, tl(link_ids))
  end

  def add_link_to_topic(attrs \\ %{}) do
    %Topic_maker{}
    |> Topic_maker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic_maker.

  ## Examples

      iex> update_topic_maker(topic_maker, %{field: new_value})
      {:ok, %Topic_maker{}}

      iex> update_topic_maker(topic_maker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic_maker(%Topic_maker{} = topic_maker, attrs) do
    topic_maker
    |> Topic_maker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic_maker.

  ## Examples

      iex> delete_topic_maker(topic_maker)
      {:ok, %Topic_maker{}}

      iex> delete_topic_maker(topic_maker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic_maker(%Topic_maker{} = topic_maker) do
    Repo.delete(topic_maker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic_maker changes.

  ## Examples

      iex> change_topic_maker(topic_maker)
      %Ecto.Changeset{source: %Topic_maker{}}

  """
  def change_topic_maker(%Topic_maker{} = topic_maker) do
    Topic_maker.changeset(topic_maker, %{})
  end
end