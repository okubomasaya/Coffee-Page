class CreateArticleHashtagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :article_hashtag_relationships do |t|

      t.bigint :article, index: true
      t.bigint :hashtag, index: true
      t.timestamps
    end
  end
end
