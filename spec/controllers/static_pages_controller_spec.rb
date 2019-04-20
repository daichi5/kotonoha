require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    it "reponds successfully" do
      get :home
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :home
      expect(response).to have_http_status "200"
    end
  end

  describe "#about" do
    it "reponds successfully" do
      get :about
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :about
      expect(response).to have_http_status "200"
    end
  end

  describe "#help" do
    it "reponds successfully" do
      get :help
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :help
      expect(response).to have_http_status "200"
    end
  end
end
