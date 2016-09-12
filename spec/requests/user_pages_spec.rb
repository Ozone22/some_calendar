require 'rails_helper'

describe 'User pages' do

  subject { page }

  describe 'Signup page' do

    let(:submit) { 'Create account' }

    before { visit signup_path }

    it { should have_link('Registration', href: signup_path) }
    it { should have_link('Login', href: signin_path) }

    describe 'with invalid information' do

      specify { expect { click_button submit }.not_to change(User, :count) }

    end

    describe 'with valid information' do
      before do
        fill_in 'Email', with: 'testEmail@email.com'
        fill_in 'Password', with: 'testPass12'
        fill_in 'Confirmation', with: 'testPass12'
      end

      it 'should increase user count' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'redirect to user events' do
        before { click_button submit }

        it { should have_link('Sign out', href: signout_path) }

      end

      describe 'redirect from signup page after registration' do
        before do
          click_button submit
          visit signup_path
        end

        it { should_not have_content('Registration') }
        it { should have_link('Sign out', href: signout_path) }
      end
    end

  end

  describe 'Edit page' do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'with invalid information' do
      before { click_button 'Submit' }

      it { should have_selector('div.alert.alert-danger') }
      it { should have_content('error') }

    end

    describe 'with valid information' do
      let(:new_fio) { 'Super Test User' }
      let(:new_email) { 'superEmail@test.com' }
      before do
        fill_in 'Email', with: new_email
        fill_in 'Full name', with: new_fio
        fill_in 'Password', with: user.password
        fill_in 'Confirmation', with: user.password
        click_button 'Submit'
      end

      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.email).to eql(new_email.downcase) }
      specify { expect(user.reload.fio).to eql(new_fio) }
      it { should_not have_content('Profile settings') }
    end


  end
end