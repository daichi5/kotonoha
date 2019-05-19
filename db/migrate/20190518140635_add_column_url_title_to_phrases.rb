class AddColumnUrlTitleToPhrases < ActiveRecord::Migration[5.2]
  def change
    add_column :phrases, :url_title, :string
  end
end
