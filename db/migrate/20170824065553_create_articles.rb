class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :img
      t.text :body
      t.string :author

      t.timestamps
    end
  end
end
