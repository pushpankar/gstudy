defmodule Gstudy.Frameworks.Framework do
  use Ecto.Schema
  import Ecto.Changeset


  schema "frameworks" do
    field :description, :string
    field :title, :string

    many_to_many :topics, Gstudy.Frameworks.Topic, join_through: Gstudy.Frameworks.Framework_junction

    timestamps()
  end

  @doc false
  def changeset(framework, attrs) do
    framework
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
