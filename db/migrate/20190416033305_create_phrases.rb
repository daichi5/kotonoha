class CreatePhrases < ActiveRecord::Migration[5.2]
  def change
    create_table :phrases do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :phrases, [:user_id, :created_at]
  end
end
