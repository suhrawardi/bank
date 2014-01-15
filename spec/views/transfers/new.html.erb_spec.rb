require 'spec_helper'

describe 'transfers/new.html.erb' do
 
  it 'renders' do 
    render
    expect(rendered).to have_selector('p')
  end 
end
