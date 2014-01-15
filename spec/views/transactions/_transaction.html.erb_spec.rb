require 'spec_helper'

describe 'transactions/_transaction.html.erb' do

  it 'renders a table row with the correct class' do
    render 'transactions/transaction', transaction: build(:transaction)
    expect(rendered).to have_selector('div.danger')
  end

  it 'shows the balance' do
    render 'transactions/transaction', transaction: build(:transaction)
    expect(rendered).to have_selector('strong', text: '0')
  end

  it 'shows the message' do
    render 'transactions/transaction', transaction: build(:transaction)
    expect(rendered).to match(/something got wrong/)
  end
end
