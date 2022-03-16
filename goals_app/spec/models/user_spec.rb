require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_length_of(:password).is_at_least(6)}
  it { should allow_value(nil).for(:password) }

  it{should have_many(:goals)}

  describe 'uniqueness' do
    before(:each) do
      FactoryBot.create(:user)
    end
    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe 'find_by_credentials' do 
    User.find_by(username: "Harry Potter").destroy
    user = FactoryBot.create(:user, username: "Harry Potter")
    context "with valid credentials" do
      it "should return correct user" do 
        expect(User.find_by_credentials("Harry Potter","password")).to eq(user)
      end
    end

    context "without valid credentials" do
      it "should return nil" do 
        expect(User.find_by_credentials("Harry Potter","wrong password")).to eq(nil)
      end
    end
  end

  describe 'is_password?' do 
    user = FactoryBot.create(:user)

    context "with a valid password" do 
        it "should return true" do 
            expect(user.is_password?("password")).to be true
        end 
    end 

    context "with an invalid password" do 
        it "should return false" do 
            expect(user.is_password?("password1")).to be false
        end 
    end 
  end 

  describe "generate_session_token" do
    user = FactoryBot.create(:user)
    it "should return different session token each time" do
      expect(user.generate_session_token).to_not eq(user.generate_session_token)
    end
  end

  describe "before validation" do
    user = User.new
    it "should not set session_token before validation" do
      expect(user.session_token).to eq(nil)
    end
  end

  describe 'password encryption' do 

    it 'does not save the password to the database' do 
        User.find_by(username: "Harry Potter").destroy
        FactoryBot.create(:user, username: "Harry Potter")
        user = User.find_by(username: 'Harry Potter')
        expect(user.password).not_to eq('password')
    end 

    it 'encrypts password using BCrypt' do 
        expect(BCrypt::Password).to receive(:create).with('password1')
        FactoryBot.build(:user, password: 'password1')
    end 
  end

  describe 'ensure_session_token' do
    user = FactoryBot.create(:user)
    it "should ensure session token exists" do 
      expect(user.session_token).to_not eq(nil)
    end
  end

  describe 'reset_session_token!' do 
    user = FactoryBot.create(:user)
    # temp_session_token = :user.session_token
    
    it "should reset the session token" do
      expect(user.session_token).to_not eq(user.reset_session_token!)
    end
  end
end
