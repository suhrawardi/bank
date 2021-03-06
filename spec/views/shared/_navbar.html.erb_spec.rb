require 'spec_helper'

describe 'shared/_navbar.html.erb' do

  context 'a user who is logged in' do

    before do
      view.stub(:user_signed_in?).and_return(true)
      view.stub(:current_user).and_return(mock_model(User))
      render 'shared/navbar'
    end

    it 'renders the navigation bar' do
      expect(rendered).to have_selector('nav ul.nav')
    end

    it 'shows an account link' do
      expect(rendered).to have_selector('li', text: 'account')
    end

    it 'shows a logout link' do
      expect(rendered).to have_selector('li', text: 'logout')
    end
  end

  context 'a user who is not logged in' do

    before do
      view.stub(:user_signed_in?).and_return(false)
      render 'shared/navbar'
    end

    it 'renders the navigation bar' do
      expect(rendered).to have_selector('nav ul.nav')
    end

    it 'shows a login link' do
      expect(rendered).to have_selector('li', text: 'login')
    end
  end
end
