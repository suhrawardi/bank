require 'spec_helper'

describe 'welcome/index.html.erb' do
 
  it 'renders' do 
    render
    expect(rendered).to have_selector('body')
  end 

  it 'contains the welcome text' do
    render
    expect(rendered).to have_selector('h2', text: 'Welcome here!')
  end
end
