class AddImageColumnsToArticle < ActiveRecord::Migration[5.1]
  def up
    add_attachment :articles, :img
  end

  def down
    remove_attachment :articles, :img
  end
end
