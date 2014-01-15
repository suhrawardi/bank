require 'spec_helper'

describe AccountsController do

  describe "GET 'index'" do
    before do
      @user = create(:user)
      @account = mock_model(Account)
      @user.stub(:account).and_return(@account)
      controller.stub(:current_user).and_return(@user)
    end

    describe 'a user that is not logged in' do

      it 'redirects to the login page' do
        get :index, user_id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'a user trying to view someone elses account' do
      before do
        sign_in @user
      end

      it 'redirects to the login page' do
        get :index, user_id: @user.id + 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'a user that is logged in' do
      before do
        sign_in @user
      end

      it 'is successful' do
        get :index, user_id: @user.id
        expect(response).to be_success
      end

      it 'has the current user' do
        expect(controller).to receive(:current_user).and_return(@user)
        get :index, user_id: @user.id
      end

      it "fetches the user's account" do
        expect(@user).to receive(:account).and_return(@account)
        get :index, user_id: @user.id
      end

      it "assigns the user's account" do
        get :index, user_id: @user.id
        expect(assigns[:account]).to eq(@account)
      end
    end
  end
end
