require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    context "should get root_url" do
      before  { get :home }

      it "response should be 200" do
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "should get about" do
      before  { get :about }

      it "response should be 200" do
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "should get help" do
      before  { get :help }

      it "response should be 200" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
