require 'spec_helper'

describe 'shared/_flash.html.erb' do

  it 'renders nothing' do
    render 'shared/flash'
    expect(rendered).to be_empty
  end

  context 'a flash notice' do
    before do
      view.stub(:notice).and_return('a notice')
      view.stub(:alert).and_return(nil)
    end

    it 'renders the flash notice' do
      render 'shared/flash'
      expect(rendered).to have_selector('.alert-success', text: 'a notice')
    end

    it 'does not have an alert holder' do
      render 'shared/flash'
      expect(rendered).not_to have_selector('.alert-danger')
    end
  end

  context 'a flash alert' do
    before do
      view.stub(:notice).and_return(nil)
      view.stub(:alert).and_return('an alert')
    end

    it 'renders the flash alert' do
      render 'shared/flash'
      expect(rendered).to have_selector('.alert-danger', text: 'an alert')
    end

    it 'does not have a notice holder' do
      render 'shared/flash'
      expect(rendered).not_to have_selector('.alert-success')
    end
  end
end

