require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation: ' do

    it "should be accepted if password and password_confirmation are the same" do
      @user = User.create(name: "Taylor", email: "tay@fake.com", password: "1234", password_confirmation: "1234")
      expect(@user.password).to eq @user.password_confirmation
    end
  
    it "should NOT be accepted if password and password_confirmation are NOT the same" do
      @user = User.create(name: "Taylor", email: "tay@fake.com", password: "1234", password_confirmation: "12345")
      expect(@user.password).not_to eq @user.password_confirmation
    end

    it 'should check if the same email is used again for account registry' do
      @user1 = User.create(name:"Taylor", email: "tay@fake.com", password: "1234", password_confirmation: "1234")
      @user2 = User.create(name:"Taylor2", email: "tay@fake.com", password: "def", password_confirmation: "def")

      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should pass if email and name are present' do
      @user = User.create(name:"Taylor", email: "tay@gmail.com", password: "1234", password_confirmation: "1234")
      expect(@user.valid?).to be true
    end

    it 'should fail if either email or name are NOT present' do
      @user = User.create(name: nil, email: "tay@fake.com", password: "1234", password_confirmation: "1234")
      expect(@user.valid?).to be false
    end
    
    it 'should check minimum passord length' do
      @user = User.create(name:"Taylor", email: "tay@fake.com", password: "a", password_confirmation: "a")
      
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 2 characters)")
    end
    
  end
  
  describe '.authenticate_with_credentials' do
     
    it 'should check if user is logged in' do
      @user = User.create(name:"Taylor", email: "tay@fake2.com", password: "1234", password_confirmation: "1234")
      login = User.authenticate_with_credentials("tay@fake2.com", "1234")
      expect(login).to eq @user
    end

    it "should accept a login with email in different CASE" do
      @user = User.create(name:"Taylor", email: "tay@fake3.com", password: "1234", password_confirmation: "1234")
      login = User.authenticate_with_credentials("TAY@fake3.com", "1234")
      expect(login).to eq @user
    end

    it "should accept an email with spaces before or after the value" do
      @user = User.create(name:"Taylor", email: "tay@fake4.com", password: "1234", password_confirmation: "1234")
      login = User.authenticate_with_credentials("   tay@fake4.com   ", "1234")
      expect(login).to eq @user
    end
  end
end