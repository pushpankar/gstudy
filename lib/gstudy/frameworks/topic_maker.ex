defmodule Gstudy.Frameworks.Topic_maker do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "topic_makers" do
    belongs_to :topic, Gstudy.Frameworks.Topic
    belongs_to :link,  Gstudy.Frameworks.Link

    timestamps()
  end

  @doc false
  def changeset(topic_maker, attrs) do
    topic_maker
    |> cast(attrs, [:topic_id, :link_id])
    |> validate_required([:topic_id, :link_id])
    |> unique_constraint(:link, name: :topic_link_index)

  end
end
