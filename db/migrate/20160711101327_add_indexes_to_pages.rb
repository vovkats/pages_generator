class AddIndexesToPages < ActiveRecord::Migration
  def change
    add_index :pages, :name
    add_index :pages, [:name, :root_id]
  end
end
