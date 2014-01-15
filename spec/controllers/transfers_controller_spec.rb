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

    describe 'a user trying to view someone elses account' do
      before do
        sign_in @user
      end

      it 'redirects to the login page' do
        get :new, user_id: @user.id + 1
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

  describe "POST 'create'" do
    before do
      @user = create(:user)
      controller.stub(:current_user).and_return(@user)
      @params = {user_id: @user.id, amount: 67, user: {name: 'Erik'}}
    end

    describe 'a user that is not logged in' do

      it 'redirects to the login page' do
        post :create, @params
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'a user trying to view someone elses account' do
      before do
        sign_in @user
      end

      it 'redirects to the login page' do
        post :create, @params.merge(user_id: @user.id + 1)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'a user that is logged in' do

      describe 'a successful transfer' do
        before do
          sign_in @user
          @another_user = mock_model(User)
          User.stub(:by_name).and_return(@another_user)
          @context = double('context')
          @context.stub(:transfer)
          Account::Transfer.stub(:new).and_return(@context)
        end

        it "redirects to the user's account page" do
          post :create, @params
          expect(response).to redirect_to(user_accounts_path)
        end

        it 'fetches the receiving user' do
          expect(User).to receive(:by_name).and_return(@another_user)
          post :create, @params
        end

        it 'creates the transfer context' do
          expect(Account::Transfer).to receive(:new).
            with(@user, @another_user).and_return(@context)
          post :create, @params
        end

        it 'does the transfer' do
          expect(@context).to receive(:transfer).with('67')
          post :create, @params
        end
      end

      describe 'a failing transfer' do
        before do
          sign_in @user
          @another_user = mock_model(User)
          User.stub(:by_name).and_return(@another_user)
          Account::Transfer.stub(:new).and_throw(ActiveRecord::RecordInvalid)
        end

        it "redirects to the user's account page" do
          post :create, @params
          expect(response).to redirect_to(new_user_transfer_path)
        end

        it 'sets the flash alert' do
          post :create, @params
          expect(flash[:alert]).to match(/RecordInvalid/)
        end
      end
    end
  end
end
