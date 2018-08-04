defmodule Gstudy.Repo.Migrations.CreateFrameworks do
  use Ecto.Migration

  def change do
    create table(:frameworks) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
