require 'spec_helper'

describe TransfersController do

  describe "GET 'new'" do
    before do
      @user = create(:user)
      controller.stub(:current_user).and_return(@user)
    end

    describe 'a user that is not logged in' do

      it 'redirects to the login page' do
        get :new, user_id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'a user that is logged in' do
      before do
        sign_in @user
      end

      it 'is successful' do
        get :new, user_id: @user.id
        expect(response).to be_success
      end
    end
  end
end
