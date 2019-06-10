# frozen_string_literal: true

class AddUrlToPhrases < ActiveRecord::Migration[5.2]
  def change
    add_column :phrases, :url, :string
  end
end
