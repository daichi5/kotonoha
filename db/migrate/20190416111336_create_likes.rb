# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :phrase, foreign_key: true

      t.timestamps
    end
    add_index :likes, %i[user_id created_at]
    add_index :likes, %i[phrase_id created_at]
  end
end
