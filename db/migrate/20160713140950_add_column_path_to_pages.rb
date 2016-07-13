class AddColumnPathToPages < ActiveRecord::Migration
  def change
    add_column :pages, :path, :text
  end
end
