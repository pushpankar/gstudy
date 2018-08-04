defmodule Gstudy.Frameworks.Framework_junction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "frameworks_junctions" do
    belongs_to :framework_id, Gstudy.Frameworks.Framework
    belongs_to :topic_id, :id, Gstudy.Frameworks.Topic

    timestamps()
  end

  @doc false
  def changeset(framework_junction, attrs) do
    framework_junction
    |> cast(attrs, [:framework_id, :topic_id])
    |> validate_required([:framwork_id, :topic_id])
  end
end
