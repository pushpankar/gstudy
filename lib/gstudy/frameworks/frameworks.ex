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
  ## Example
  iex> create_topic(%{name: "abc", links: [%{url: abc}, %{url: xyz}]})
  """
  def create_topic(topic) do
    # Handle fail case
    topic_id = elem(insert_topic(%{name: topic.name}), 1).id

    link_ids = Enum.map(topic.links, fn(x) -> elem(link_to_id(x), 1).id end)
    associate_topic_link(topic_id, link_ids)
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
    |> Ecto.Changeset.put_assoc(:links, [change_link(%Link{})])
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
  def associate_topic_link(topic_id, []), do: {:ok, get_topic(topic_id)}
  def associate_topic_link(topic_id, link_ids) do
    add_link_to_topic(%{topic_id: topic_id, link_id: hd(link_ids)})
    associate_topic_link(topic_id, tl(link_ids))
  end

  @doc """
  Inserts row in topic-link junction table
  """
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

  alias Gstudy.Frameworks.Framework

  @doc """
  Returns the list of frameworks.

  ## Examples

  iex> list_frameworks()
  [%Framework{}, ...]

  """
  def list_frameworks do
    Framework
    |> Repo.all()
    |> Repo.preload(topics: [:links])
  end

  @doc """
  Gets a single framework.

  Raises `Ecto.NoResultsError` if the Framework does not exist.

  ## Examples

      iex> get_framework!(123)
      %Framework{}

      iex> get_framework!(456)
      ** (Ecto.NoResultsError)

  """
  def get_framework!(id) do
    Repo.get!(Framework, id)
    |> Repo.preload(topics: [:links])
  end

  @doc """
  Creates a framework.

  ## Examples
  #
  iex> create_framework(%{title: "Learn Nodejs", 
    description: "Learn Nodejs in 30 Days from scratch"
    topics: [%{name: "abc", links: [%{url: "abc.com"}, %{url: "xyz.in"}]}, 
             %{name: "abcd", links: [%{url: "abc.com"}, %{url: "xyz.com"}]}
            ]
    })
      iex> create_framework(%{field: value})
      {:ok, %Framework{}}

      iex> create_framework(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_framework(framework \\ %{}) do
    framework_id = elem(insert_framework(%{title: framework.title, description: framework.description}), 1).id

    topic_ids = Enum.map(framework.topics, fn(x) -> elem(create_topic(x), 1).id end)
    associate_framework_topic(framework_id, topic_ids)
  end

  def insert_framework(attrs \\ %{}) do
    %Framework{}
    |> Framework.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a framework.

  ## Examples

      iex> update_framework(framework, %{field: new_value})
      {:ok, %Framework{}}

      iex> update_framework(framework, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_framework(%Framework{} = framework, attrs) do
    framework
    |> Framework.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Framework.

  ## Examples

      iex> delete_framework(framework)
      {:ok, %Framework{}}

      iex> delete_framework(framework)
      {:error, %Ecto.Changeset{}}

  """
  def delete_framework(%Framework{} = framework) do
    Repo.delete(framework)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking framework changes.

  ## Examples

      iex> change_framework(framework)
      %Ecto.Changeset{source: %Framework{}}

  """
  def change_framework(%Framework{} = framework) do
    Framework.changeset(framework, %{})
    |> Ecto.Changeset.put_assoc(:topics, [change_topic(%Topic{})])
  end

  alias Gstudy.Frameworks.Framework_junction

  @doc """
  Returns the list of frameworks_junctions.

  ## Examples

      iex> list_frameworks_junctions()
      [%Framework_junction{}, ...]

  """
  def list_frameworks_junctions do
    Repo.all(Framework_junction)
  end

  @doc """
  Gets a single framework_junction.

  Raises `Ecto.NoResultsError` if the Framework junction does not exist.

  ## Examples

      iex> get_framework_junction!(123)
      %Framework_junction{}

      iex> get_framework_junction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_framework_junction!(id), do: Repo.get!(Framework_junction, id)


  def associate_framework_topic(framework_id, []), do: {:ok, get_framework!(framework_id)}
  def associate_framework_topic(framework_id, topic_ids) do
    add_topic_to_frameworks(%{framework_id: framework_id, topic_id: hd(topic_ids)})
    associate_framework_topic(framework_id, tl(topic_ids))
  end

  @doc """
  Creates a framework_junction.

  ## Examples

      iex> create_framework_junction(%{field: value})
      {:ok, %Framework_junction{}}

      iex> create_framework_junction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def add_topic_to_frameworks(attrs \\ %{}) do
    %Framework_junction{}
    |> Framework_junction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a framework_junction.

  ## Examples

      iex> update_framework_junction(framework_junction, %{field: new_value})
      {:ok, %Framework_junction{}}

      iex> update_framework_junction(framework_junction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_framework_junction(%Framework_junction{} = framework_junction, attrs) do
    framework_junction
    |> Framework_junction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Framework_junction.

  ## Examples

      iex> delete_framework_junction(framework_junction)
      {:ok, %Framework_junction{}}

      iex> delete_framework_junction(framework_junction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_framework_junction(%Framework_junction{} = framework_junction) do
    Repo.delete(framework_junction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking framework_junction changes.

  ## Examples

      iex> change_framework_junction(framework_junction)
      %Ecto.Changeset{source: %Framework_junction{}}

  """
  def change_framework_junction(%Framework_junction{} = framework_junction) do
    Framework_junction.changeset(framework_junction, %{})
  end
end
