class DropImageColumnsToArticle < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :img
  end
end
