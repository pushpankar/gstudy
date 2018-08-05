defmodule Gstudy.Repo.Migrations.CreateTopicMakers do
  use Ecto.Migration

  def change do
    create table(:topic_makers, primary_key: false) do
      add :topic_id, references(:topics, on_delete: :nothing)
      add :link_id, references(:links, on_delete: :nothing)

      timestamps()
    end

    create index(:topic_makers, [:topic_id])
    create index(:topic_makers, [:link_id])
    create unique_index(:topic_makers, [:topic_id, :link_id], name: :topic_link_index)
  end
end
