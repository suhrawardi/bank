require 'spec_helper'

describe 'account/index.html.erb' do

  def do_render
    render template: 'accounts/index', handlers: [:erb]
  end

  before do
    @user = mock_model(User, name: 'someone')
    @account = mock_model(Account, balance: 99, user: @user)
    assign(:account, @account)
  end
 
  it 'renders' do 
    do_render
    expect(rendered).to have_selector('body')
  end 

  it "contains the user's name" do
    do_render
    expect(rendered).to have_selector('p', text: 'account of someone')
  end

  it "contains the user's balance" do
    do_render
    expect(rendered).to have_selector('dd', text: '99')
  end
end
