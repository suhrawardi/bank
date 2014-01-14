require 'spec_helper'

describe 'shared/_flash.html.erb' do

  def do_render
    render template: 'shared/_flash', handlers: [:erb]
  end

  it 'renders nothing' do
    do_render
    expect(rendered).to be_empty
  end

  context 'a flash notice' do
    before do
      view.stub(:notice).and_return('a notice message')
      view.stub(:alert).and_return(nil)
    end

    it 'renders the flash notice' do
      do_render
      expect(rendered).to have_selector('.notice', text: 'a notice message')
    end

    it 'does not have an alert holder' do
      do_render
      expect(rendered).not_to have_selector('.warning')
    end
  end

  context 'a flash alert' do
    before do
      view.stub(:notice).and_return(nil)
      view.stub(:alert).and_return('an alert message')
    end

    it 'renders the flash alert' do
      do_render
      expect(rendered).to have_selector('.warning', text: 'an alert message')
    end

    it 'does not have a notice holder' do
      do_render
      expect(rendered).not_to have_selector('.notice')
    end
  end
end

