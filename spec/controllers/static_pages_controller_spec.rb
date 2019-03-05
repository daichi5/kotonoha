require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    context "get root_url" do
      before  { get :home }

      it "response is 200" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
