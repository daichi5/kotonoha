# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :content
      t.references :phrase, foreign_key: true

      t.timestamps
    end
    add_index :comments, %i[phrase_id created_at]
  end
end
