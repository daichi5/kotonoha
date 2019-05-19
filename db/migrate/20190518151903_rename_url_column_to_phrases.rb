class RenameUrlColumnToPhrases < ActiveRecord::Migration[5.2]
  def change
    rename_column :phrases, :url, :quoted
  end
end
