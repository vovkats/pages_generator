class RemoveColumnSlugPages < ActiveRecord::Migration
  def change
    remove_column :pages, :slug, :string
  end
end
