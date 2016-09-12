require 'rails_helper'

describe 'User pages' do

  subject { page }

  describe 'Signup page' do

    let(:submit) { 'Create account' }

    before { visit signup_path }

    it { should have_link('Sign in', href: signin_path) }

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
    end

  end
end