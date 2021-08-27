class ChageDataBodyArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :body, :text, null: false, :limit => 4294967295
  end
end
