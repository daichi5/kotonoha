# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    before do
      FactoryBot.create(:like)
    end

    it 'reponds successfully' do
      get :home
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      get :home
      expect(response).to have_http_status '200'
    end
  end

  describe '#about' do
    it 'reponds successfully' do
      get :about
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      get :about
      expect(response).to have_http_status '200'
    end
  end

  describe '#contact' do
    it 'reponds successfully' do
      get :contact
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      get :contact
      expect(response).to have_http_status '200'
    end
  end
end
