require 'spec_helper'

describe 'shared/_flash.html.erb' do

  it 'renders nothing' do
    render 'shared/flash'
    expect(rendered).to be_empty
  end

  context 'a flash notice' do
    before do
      view.stub(:notice).and_return('a notice message')
      view.stub(:alert).and_return(nil)
    end

    it 'renders the flash notice' do
      render 'shared/flash'
      expect(rendered).to have_selector('.success', text: 'a notice message')
    end

    it 'does not have an alert holder' do
      render 'shared/flash'
      expect(rendered).not_to have_selector('.danger')
    end
  end

  context 'a flash alert' do
    before do
      view.stub(:notice).and_return(nil)
      view.stub(:alert).and_return('an alert message')
    end

    it 'renders the flash alert' do
      render 'shared/flash'
      expect(rendered).to have_selector('.danger', text: 'an alert message')
    end

    it 'does not have a notice holder' do
      render 'shared/flash'
      expect(rendered).not_to have_selector('.success')
    end
  end
end

