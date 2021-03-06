require 'spec_helper'

describe Account::Transfer do

  context 'transfer' do

    subject(:source) do
      create(:user)
    end

    subject(:destination) do
      create(:user)
    end

    context 'a successful transfer' do

      it 'decreases the source account' do
        Account::Transfer.new(source, destination).transfer(16)
        expect(source.reload.account.balance).to eq(84)
      end

      it 'increases the destination account' do
        Account::Transfer.new(source, destination).transfer(16)
        expect(destination.reload.account.balance).to eq(116)
      end

      it 'logs the successful transaction' do
        expect do
          Account::Transfer.new(source, destination).transfer(46)
        end.to change{ Transaction.where(status: 'success').count }.by(1)
      end
    end

    context 'a transfer without a user' do

      it 'does not decrease the source account' do
        Account::Transfer.new(source, nil).transfer(138) rescue nil
        expect(source.reload.account.balance).to eq(100)
      end

      it 'raises an error' do
        expect do
          Account::Transfer.new(source, nil).transfer(108)
        end.to raise_error(ActiveRecord::RecordNotFound, 'User not found')
      end
    end

    context 'a failing transfer' do

      it 'does not decrease the source account' do
        Account::Transfer.new(source, destination).transfer(138) rescue nil
        expect(source.reload.account.balance).to eq(100)
      end

      it 'does not increase the destination account' do
        Account::Transfer.new(source, destination).transfer(128) rescue nil
        expect(destination.reload.account.balance).to eq(100)
      end

      it 'logs the failing transaction' do
        expect do
          Account::Transfer.new(source, destination).transfer(118) rescue nil
        end.to change{ Transaction.where(status: 'danger').count }.by(1)
      end

      it 'raises an error' do
        expect do
          Account::Transfer.new(source, destination).transfer(108)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
