require 'spec_helper'

describe 'welcome/index.html.erb' do

  def do_render
    render template: 'welcome/index', handlers: [:erb]
  end
 
  it 'renders' do 
    do_render
    expect(rendered).to have_selector('body')
  end 

  it 'contains the welcome text' do
    do_render
    expect(rendered).to have_selector('h2', text: 'Welcome here!')
  end
end
