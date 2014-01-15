require 'spec_helper'

describe 'transfers/new.html.erb' do

  before do
    view.stub(:current_user).and_return(mock_model(User))
  end
 
  it 'renders a form' do 
    render
    expect(rendered).to have_selector('form')
  end 
 
  it 'has a text field for the amount' do 
    render
    expect(rendered).to have_selector('input[name="amount"]')
  end 
 
  it 'has a text field for the receiving user' do 
    render
    expect(rendered).to have_selector('input[name="name"]')
  end 
end
