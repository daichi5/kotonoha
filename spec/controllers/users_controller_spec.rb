require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)   
        login(@user)
        get :index
      end

      it ("responds successfully") { expect(response).to be_successful } 
      it ("returns a 200 response") { expect(response).to have_http_status "200" }
    end

    context "as a guest" do
      before do
        get :index
      end

      it ("returns a 302 response") { expect(response).to have_http_status "302" }
      it ("redirects to login-page") { expect(response).to redirect_to "/login" }
    end
  end

  describe "#show" do
    before do
      @showed_user = FactoryBot.create(:user)
    end

    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        login(@user)
        get :show, params: { id: @showed_user.id }
      end
      
      it ("responds successfully") { expect(response).to be_successful }
      it ("returns a 200 response") { expect(response).to have_http_status "200" }
    end

    context "as a guest" do
      before do
        get :show, params: { id: @showed_user.id }
      end

      it ("responds successfully") { expect(response).to be_successful }
      it ("returns a 200 response") { expect(response).to have_http_status "200" }
    end
  end

  describe "#new" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        login(@user)
      end

      it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end

      it "redirects to login-page" do
        get :new
        expect(response).to redirect_to @user
      end
    end

    context "as a guest" do
      it "responds successfuly" do
        get :new
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        get :new
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        login(@user)
      end

      it "does not create a user" do
        user_params = FactoryBot.attributes_for(:user)
        expect {
          post :create, params: { user: user_params }
        }.to_not change(User, :count)
      end

      it "returns a 302 response" do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to user-page" do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
        expect(response).to redirect_to @user 
      end
    end

    context "as a guest" do
      it "create a user" do
        user_params = FactoryBot.attributes_for(:user)
        expect {
          post :create, params: { user: user_params }
        }.to change(User, :count).by(1)
      end

      it "returns a 302 reponse" do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to user-page" do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
        expect(response).to redirect_to User.find_by(email: user_params[:email])
      end
    end
  end

  describe "#edit" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        login(@user)
      end

      it "responds successfully" do
        get :edit, params: { id: @user }
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        get :edit, params: { id: @user }
        expect(response).to have_http_status "200"
      end 
    end

    context "as an unauthorized user" do
      before do
        user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
        login(user)
      end

      it "returns a 302 response" do
        get :edit, params: { id: @other_user.id }
        expect(response).to have_http_status "302"
      end

      it "redirect_to root_path" do
        get :edit, params: { id: @other_user.id }
        expect(response).to redirect_to root_path
      end
    end

    context "as a guest" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "returns a 302 response" do
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end

      it "redirect_to root_path" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user, name: "test user")
        login(@user)
      end

      it "udpates a user" do
        user_params = FactoryBot.attributes_for(:user, name: "updated user")
        post :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "updated user"
      end
    end

    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user, name: "test user")
        other_user = FactoryBot.create(:user)
        login(other_user)
      end

      it "does not update a user" do
        user_params = FactoryBot.attributes_for(:user, name: "updated user")
        post :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "test user"
      end
    end

    context "as a guest" do
      before do
        @user = FactoryBot.create(:user, name: "test user")
      end

      it "does not update a user" do
        user_params = FactoryBot.attributes_for(:user, name: "updated user")
        post :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "test user"
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a user" do
        user = FactoryBot.create(:user)
        login(user)
        expect {
          delete :destroy, params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
    end

    context "as an unauthorized user" do
      it "does not deletes a user" do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        login(other_user)
        expect {
          delete :destroy, params: { id: user.id }
        }.to_not change(User, :count)
      end
    end

    context "as a guest" do
      it "does not deletes a user" do
        user = FactoryBot.create(:user)
        expect {
          delete :destroy, params: { id: user.id }
        }.to_not change(User, :count)
      end
    end
  end
end
