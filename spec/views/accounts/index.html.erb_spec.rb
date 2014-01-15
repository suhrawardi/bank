require 'spec_helper'

describe 'accounts/index.html.erb' do

  before do
    @transaction = mock_model(Transaction)
    @user = mock_model(User, name: 'someone')
    @account = mock_model(Account, balance: 99,
                          user: @user, transactions: [@transaction])
    assign(:account, @account)
    stub_template('transactions/_transaction.html.erb' => 'transaction mock')
  end
 
  it 'renders' do 
    render
    expect(rendered).to have_selector('body')
  end 

  it "contains the user's name" do
    render
    expect(rendered).to have_selector('p', text: 'account of someone')
  end

  it "contains the user's balance" do
    render
    expect(rendered).to have_selector('dd', text: '99')
  end

  it 'renders the transactions' do
    render
    expect(rendered).to match(/transaction mock/)
  end
end
