defmodule Gstudy.FrameworksTest do
  use Gstudy.DataCase

  alias Gstudy.Frameworks

  describe "links" do
    alias Gstudy.Frameworks.Link

    @valid_attrs %{url: "some url"}
    @update_attrs %{url: "some updated url"}
    @invalid_attrs %{url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Frameworks.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Frameworks.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Frameworks.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Frameworks.create_link(@valid_attrs)
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, link} = Frameworks.update_link(link, @update_attrs)
      assert %Link{} = link
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Frameworks.update_link(link, @invalid_attrs)
      assert link == Frameworks.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Frameworks.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Frameworks.change_link(link)
    end
  end

  describe "topics" do
    alias Gstudy.Frameworks.Topic

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Frameworks.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Frameworks.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Frameworks.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Frameworks.create_topic(@valid_attrs)
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Frameworks.update_topic(topic, @update_attrs)
      assert %Topic{} = topic
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Frameworks.update_topic(topic, @invalid_attrs)
      assert topic == Frameworks.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Frameworks.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Frameworks.change_topic(topic)
    end
  end

  describe "frameworks" do
    alias Gstudy.Frameworks.Framework

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def framework_fixture(attrs \\ %{}) do
      {:ok, framework} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Frameworks.create_framework()

      framework
    end

    test "list_frameworks/0 returns all frameworks" do
      framework = framework_fixture()
      assert Frameworks.list_frameworks() == [framework]
    end

    test "get_framework!/1 returns the framework with given id" do
      framework = framework_fixture()
      assert Frameworks.get_framework!(framework.id) == framework
    end

    test "create_framework/1 with valid data creates a framework" do
      assert {:ok, %Framework{} = framework} = Frameworks.create_framework(@valid_attrs)
    end

    test "create_framework/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_framework(@invalid_attrs)
    end

    test "update_framework/2 with valid data updates the framework" do
      framework = framework_fixture()
      assert {:ok, framework} = Frameworks.update_framework(framework, @update_attrs)
      assert %Framework{} = framework
    end

    test "update_framework/2 with invalid data returns error changeset" do
      framework = framework_fixture()
      assert {:error, %Ecto.Changeset{}} = Frameworks.update_framework(framework, @invalid_attrs)
      assert framework == Frameworks.get_framework!(framework.id)
    end

    test "delete_framework/1 deletes the framework" do
      framework = framework_fixture()
      assert {:ok, %Framework{}} = Frameworks.delete_framework(framework)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_framework!(framework.id) end
    end

    test "change_framework/1 returns a framework changeset" do
      framework = framework_fixture()
      assert %Ecto.Changeset{} = Frameworks.change_framework(framework)
    end
  end

  describe "topics" do
    alias Gstudy.Frameworks.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Frameworks.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Frameworks.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Frameworks.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Frameworks.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Frameworks.update_topic(topic, @update_attrs)
      assert %Topic{} = topic
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Frameworks.update_topic(topic, @invalid_attrs)
      assert topic == Frameworks.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Frameworks.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Frameworks.change_topic(topic)
    end
  end

  describe "topic_makers" do
    alias Gstudy.Frameworks.Topic_maker

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def topic_maker_fixture(attrs \\ %{}) do
      {:ok, topic_maker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Frameworks.create_topic_maker()

      topic_maker
    end

    test "list_topic_makers/0 returns all topic_makers" do
      topic_maker = topic_maker_fixture()
      assert Frameworks.list_topic_makers() == [topic_maker]
    end

    test "get_topic_maker!/1 returns the topic_maker with given id" do
      topic_maker = topic_maker_fixture()
      assert Frameworks.get_topic_maker!(topic_maker.id) == topic_maker
    end

    test "create_topic_maker/1 with valid data creates a topic_maker" do
      assert {:ok, %Topic_maker{} = topic_maker} = Frameworks.create_topic_maker(@valid_attrs)
    end

    test "create_topic_maker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_topic_maker(@invalid_attrs)
    end

    test "update_topic_maker/2 with valid data updates the topic_maker" do
      topic_maker = topic_maker_fixture()
      assert {:ok, topic_maker} = Frameworks.update_topic_maker(topic_maker, @update_attrs)
      assert %Topic_maker{} = topic_maker
    end

    test "update_topic_maker/2 with invalid data returns error changeset" do
      topic_maker = topic_maker_fixture()
      assert {:error, %Ecto.Changeset{}} = Frameworks.update_topic_maker(topic_maker, @invalid_attrs)
      assert topic_maker == Frameworks.get_topic_maker!(topic_maker.id)
    end

    test "delete_topic_maker/1 deletes the topic_maker" do
      topic_maker = topic_maker_fixture()
      assert {:ok, %Topic_maker{}} = Frameworks.delete_topic_maker(topic_maker)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_topic_maker!(topic_maker.id) end
    end

    test "change_topic_maker/1 returns a topic_maker changeset" do
      topic_maker = topic_maker_fixture()
      assert %Ecto.Changeset{} = Frameworks.change_topic_maker(topic_maker)
    end
  end
end
