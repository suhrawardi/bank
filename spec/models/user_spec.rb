require 'spec_helper'

describe User do

  describe 'validations' do

    subject do
      build(:user)
    end

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with a name that is not unique' do
      subject.name = create(:user).name
      expect(subject).not_to be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with an email that is not unique' do
      another_user = create(:user)
      subject.email = another_user.email
      expect(subject).not_to be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with an incorrect password confirmation' do
      subject.password_confirmation = 'blah'
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do

    subject do
      build(:user)
    end

    it 'has an account' do
      expect(subject).to respond_to(:account)
    end
  end

  context 'bank account' do

    it 'adds a bank account on creation' do
      expect { create(:user) }.to change{ Account.count }.by(1)
    end

    it 'destroys the bank account when the user is destroyed' do
      user = create(:user)
      expect { User.destroy(user) }.to change{ Account.count }.by(-1)
    end

    it 'initializes the bank account with a 100 euro balance' do
      user = create(:user)
      expect(user.account.balance).to eq(100)
    end
  end

  context '#named' do

    before do
      @maarten = create(:user, name: 'maarten')
      @monic = create(:user, name: 'monic')
    end

    it 'finds the users with the correct name' do
      expect(User.named('maarten')).to include(@maarten)
    end

    it 'does not find users with another name' do
      expect(User.named('maarten')).not_to include(@monic)
    end
  end

  context '#named' do

    before do
      @carla = create(:user, name: 'carla')
    end

    it 'finds only one user with the correct name' do
      expect(User.by_name('carla')).to eq(@carla)
    end
  end
end
