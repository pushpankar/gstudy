defmodule Gstudy.Repo.Migrations.CreateFrameworksJunctions do
  use Ecto.Migration

  def change do
    create table(:frameworks_junctions, primary_key: false) do
      add :framework_id, references(:frameworks, on_delete: :nothing)
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:frameworks_junctions, [:framework_id])
    create index(:frameworks_junctions, [:topic_id])
  end
end
