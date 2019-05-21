class AddAuthorToPhrases < ActiveRecord::Migration[5.2]
  def change
    add_column :phrases, :author, :string 
  end
end
