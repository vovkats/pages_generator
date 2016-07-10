class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :content
      t.integer :root_id

      t.timestamps null: false
    end
  end
end
