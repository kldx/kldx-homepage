class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :title,            null: false
      t.string :default_image,    null: false
      t.text :content,            null: false
      t.string :slug,             null: false,      unique: true

      t.timestamps
    end
  end
end
