require 'rails_helper'

RSpec.describe "static_pages/help.html.erb", type: :view do
  describe do
    it 'render home page' do
      render
      expect(rendered).to include("kotonoha")
    end
   end
end
