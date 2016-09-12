require 'rails_helper'

describe User do

  before do
    params = { email: 'testEmail@email.com', password: '17d3100Z', password_confirmation: '17d3100Z' }
    @user = User.new(params)
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:fio) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe 'when email is not present' do

    before { @user.email = ' ' }

    it { should_not be_valid }

  end

  describe 'when email format is invalid' do

    it 'should be invalid' do

      addresses = %w(user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com)

      addresses.each do |invalid_address|

        @user.email = invalid_address
        expect(@user).not_to be_valid

      end
    end
  end

  describe 'when email format is valid' do

    it 'should be valid' do

      addresses = %w(user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn)

      addresses.each do |valid_address|

        @user.email = valid_address
        expect(@user).to be_valid

      end
    end
  end


  describe 'when user with some email already exist' do

    before do
      user_dup = @user.dup
      user_dup.email = @user.email.upcase
      user_dup.save
    end

    it { should_not be_valid }

  end

  describe 'email should be saved in downcase' do

    let(:mixed_email) { 'FooBaR@foo.com' }

    before do
      @user.email = mixed_email
      @user.save
    end

    specify { expect(@user.email).to eq(mixed_email.downcase) }

  end

  describe 'when password is not present' do

    before { @user.password = @user.password_confirmation = '' }

    it { should_not be_valid }

  end

  describe 'when password_confirmation is mismatch' do

    before { @user.password_confirmation = 'mismatch' }

    it { should_not be_valid }

  end

  describe 'when password is too short' do

    before { @user.password = @user.password_confirmation = 'Dd1' }

    it { should_not be_valid }

  end

  describe 'when password not contain digits' do

    before { @user.password = @user.password_confirmation = 'passssS' }

    it { should_not be_valid }

  end

  describe 'when password not contain capital letters' do

    before { @user.password = @user.password_confirmation = 'password2' }

    it { should_not be_valid }

  end

  describe 'when password valid' do

    before { @user.password = @user.password_confirmation = 'passworD2' }

    it { should be_valid }

  end

  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end

  end

end