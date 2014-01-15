require 'spec_helper'

# TODO: This view is in dire need of some refactoring... :-)

describe 'transactions/_transaction.html.erb' do

  context 'a failed transaction' do

    before do
      transaction = build(:transaction, status: :danger)
      render 'transactions/transaction', transaction: transaction
    end

    it 'renders a div with the correct class' do
      expect(rendered).to have_selector('div.alert-danger')
    end

    it 'shows that it failed' do
      expect(rendered).to match(/failed/)
    end

    it 'shows the msg' do
      expect(rendered).to match(/something got wrong!/)
    end
  end

  context 'a successful transaction' do
    before do
      transaction = build(:transaction, status: 'success')
      render 'transactions/transaction', transaction: transaction
    end

    it 'renders a div with the correct class' do
      expect(rendered).to have_selector('div.alert-success')
    end

    it 'shows not that it failed' do
      expect(rendered).not_to match(/failed/)
    end

    it 'does not show the msg' do
      expect(rendered).not_to match(/something got wrong!/)
    end
  end
end
