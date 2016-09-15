require 'rails_helper'

describe 'Event pages' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
    @user_event = FactoryGirl.create(:event, name: 'userEvent', user: user)
  end

  subject { page }

  describe 'user events pages' do

    before { visit user_events_path(user) }

    describe 'create via ajax', js: true do

      before { click_link('Create event', href: new_user_event_path(user)) }

      describe 'fill with invalid data' do

        describe 'empty fields' do

          before { click_button 'Submit' }

          it { should have_selector('div.alert.alert-danger') }

        end

        describe 'invalid date' do

          before do
            fill_in 'Name', with: 'testEvent'
            fill_in 'Date', with: Date.yesterday.to_s
            click_button 'Submit'
          end

          it { should have_selector('div.alert.alert-danger') }

        end
      end

      describe 'fill with valid data' do
        before do
          fill_in 'Name', with: 'testEvent'
          fill_in 'Date', with: Date.tomorrow.to_s
          click_button 'Submit'
        end

        it { should have_link('testEvent') }

      end
    end

    describe 'user events pages', js: true do

      let(:another_user) { FactoryGirl.create(:user) }

      before { @another_user_event = FactoryGirl.create(:event, name: 'anotherUserEvent', user: another_user) }

      describe 'another user events pages' do

        before { visit user_events_path(another_user) }

        # Another user not signed in. Signed in - user
        it { should_not have_link(@another_user_event.name) }

        describe 'index page' do

          before { visit events_path }

          it { should have_link(@another_user_event.name) }
          it { should have_link(@user_event.name) }

          describe 'click on another user event' do

            before { click_link(@another_user_event.name) }

            it { should_not have_button('Remove') }
            it { should_not have_button('Submit') }

          end
        end
      end

      describe 'current user event pages' do

        before { visit user_events_path(user) }

        it { should_not have_link(@another_user_event.name) }
        it { should have_link(@user_event.name) }

        describe 'edit event' do

          before { click_link(@user_event.name) }

          describe 'invalid edit' do

            before do
              fill_in 'Name', with: ''
              click_button 'Submit'
            end

            it { should have_selector('div.alert.alert-danger') }

          end

          describe 'edit with valid data' do

            before do
              fill_in 'Name', with: 'newName'
              fill_in 'Date', with: Date.tomorrow
              click_button 'Submit'
            end

            it { should have_link('newName') }

          end
        end

        describe 'remove event' do

          before do
            click_link(@user_event.name)
            click_link('Remove')
            accept_alert
          end

          it { should_not have_link(@user_event.name) }

        end
      end
    end

  end
end