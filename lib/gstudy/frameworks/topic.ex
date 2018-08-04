defmodule Gstudy.Frameworks.Topic do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topics" do
    field :name, :string
    many_to_many :links, Gstudy.Frameworks.Link, join_through: Gstudy.Frameworks.Topic_maker
    many_to_many :frameworks, Gstudy.Frameworks.Framework, join_through: Gstudy.Frameworks.Framework_junction

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
