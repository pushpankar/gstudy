defmodule Gstudy.Frameworks.Link do
  use Ecto.Schema
  import Ecto.Changeset


  schema "links" do
    field :url, :string
    many_to_many :topics, Gstudy.Frameworks.Topic, join_through: Gstudy.Frameworks.Topic_maker

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
