require 'rails_helper'

describe 'Session pages' do

  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  describe 'Sign in' do

    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_selector('div.alert.alert-danger') }
      it { should have_content('Invalid email or password') }

      describe 'redirect to another page after invalid sign in' do
        before { visit signup_path }

        it { should_not have_selector('div.alert.alert-danger') }

      end

      describe 'with valid information' do

        let(:cookies) { Capybara.current_session.driver.request.cookies }

        describe '(without remembering)' do
          before { sign_in user }

          it { should have_link('Sign out', href: signout_path) }
          specify { expect(cookies['origin_remember_token']).to be_falsey }
        end

        describe '(with remembering)' do
          before { sign_in(user, true) }

          it { should have_link('Sign out', href: signout_path) }
          specify { expect(cookies['origin_remember_token']).not_to be_nil }

        end
      end
    end

    describe 'unsigned user redirect' do
      before { visit user_events_path(user) }

      it { should_not have_link('Sign out', href: signout_path) }
      it { should have_content('Login') }
    end

    describe 'signed in user redirect' do
      before do
        sign_in user
        visit signin_path
      end

      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_content('Login') }

    end

  end

  describe 'Sign out' do
    before do
      sign_in user
      click_link 'Sign out'
    end

    it { should have_selector('div.alert.alert-success') }
    it { should have_content('Successfully signed out') }
  end
end