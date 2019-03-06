require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :view do
  it 'render home page' do
    render
    expect(rendered).to include("hogehoge")
  end
end
