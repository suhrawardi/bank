require 'spec_helper'

describe User do

  context 'validations' do

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

    it 'is not valid without an email' do
      subject.email = nil
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
end
