class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :topics, :slug, unique: true
  end
end
