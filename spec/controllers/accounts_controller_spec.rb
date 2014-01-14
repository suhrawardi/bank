require 'spec_helper'

describe AccountsController do

  describe "GET 'index'" do
    before do
      @user = create(:user)
      @account = mock_model(Account)
      @user.stub(:account).and_return(@account)
      User.stub(:find).and_return(@user)
    end

    describe 'a user that is not logged in' do

      it 'redirects to the login page' do
        get :index, user_id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'a user that is logged in' do
      before do
        sign_in @user
      end

      it 'is successful' do
        get :index, user_id: 1
        expect(response).to be_success
      end

      it 'fetches the user' do
        expect(User).to receive(:find).with('1')
        get :index, user_id: 1
      end

      it "fetches the user's account" do
        expect(@user).to receive(:account).and_return(@account)
        get :index, user_id: 1
      end

      it "assigns the user's account" do
        get :index, user_id: 1
        expect(assigns[:account]).to eq(@account)
      end
    end
  end
end
