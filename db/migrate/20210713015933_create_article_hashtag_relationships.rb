class CreateArticleHashtagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :article_hashtag_relationships do |t|

      t.references :article, index: true, type: :bigint, foreign_key: true
      t.references :hashtag, index: true, type: :bigint, foreign_key: true
      t.timestamps
    end
  end
end
