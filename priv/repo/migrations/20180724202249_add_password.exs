defmodule Gstudy.Repo.Migrations.AddPassword do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      add :password, :string
    end

  end
end
