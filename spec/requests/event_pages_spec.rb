require 'rails_helper'

describe 'Event pages' do

  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }

  before do
    sign_in user
    @user_event = FactoryGirl.create(:event, name: 'userEvent', user: user)
    @another_user_event = FactoryGirl.create(:event, name: 'anotherUserEvent', user: another_user)
  end

  subject { page }

  describe 'index page - create' do

    before { visit user_events_path(user) }

    describe 'create form', js: true do

      before { click_link('Create event', href: new_user_event_path(user)) }

      it { should_not have_content('Selected day') }

      describe 'fill with invalid data' do

        describe 'empty fields' do

          before { click_button 'Submit' }

          it { should have_selector('div.alert.alert-danger') }

        end

        describe 'invalid date' do

          before do
            fill_event_name_date(date: Date.yesterday)
            select 'never', from: 'Repeat'
            click_button 'Submit'
          end

          it { should have_selector('div.alert.alert-danger') }

        end
      end

      describe 'never repeat - fill with valid data' do
        before do
          fill_event_name_date
          select 'never', from: 'Repeat'
          click_button 'Submit'
        end

        it { should have_link('testEvent') }

      end

      describe 'daily repeat - fill with invalid data' do
        before do
          fill_event_name_date
          select 'daily', from: 'Repeat'
          click_button 'Submit'
        end

        it { should have_selector('div.alert.alert-danger') }
      end

      describe 'daily repeat - fill with invalid data(negative number)' do
        before do
          fill_event_name_date
          select 'daily', from: 'Repeat'
          fill_in 'Every n days', with: '-1'
          click_button 'Submit'
        end

        it { should_not have_link('testEvent') }
        it { should have_button('Submit') }

      end

      describe 'daily repeat - fill with valid data' do
        before do
          fill_event_name_date
          select 'daily', from: 'Repeat'
          fill_in 'Every n days', with: '2'
          click_button 'Submit'
        end

        it { should have_link('testEvent') }
      end

      describe 'weekly repeat - fill with invalid data' do
        before do
          fill_event_name_date
          select 'weekly', from: 'Repeat'
          fill_in 'Every n weeks', with: '2'
          click_button 'Submit'
        end

        it { should have_selector('div.alert.alert-danger') }
      end

      describe 'weekly repeat - fill with valid data' do
        before do
          fill_event_name_date
          select 'weekly', from: 'Repeat'
          fill_in 'Every n weeks', with: '1'
          check 'event_repeats_weekly_days_of_the_week_5'
          click_button 'Submit'
        end

        it { should have_link('testEvent') }
      end

      describe 'monthly repeat - fill with invalid data' do
        before do
          fill_event_name_date
          select 'monthly', from: 'Repeat'
          click_button 'Submit'
        end

        it { should have_selector('div.alert.alert-danger') }
      end

      describe 'monthly repeat - fill with valid data' do
        before do
          fill_event_name_date
          select 'monthly', from: 'Repeat'
          fill_in 'Every n months', with: '1'
          click_button 'Submit'
        end

        it { should have_link('testEvent') }
      end

      describe 'yearly repeat - fill with invalid data' do
        before do
          fill_event_name_date
          select 'yearly', from: 'Repeat'
          fill_in 'Every n years', with: '1'
          click_button 'Submit'
        end

        it { should have_selector('div.alert.alert-danger') }
      end

      describe 'yearly repeat - fill with valid data' do
        before do
          fill_event_name_date
          select 'yearly', from: 'Repeat'
          fill_in 'Every n years', with: '1'
          check 'event_repeats_yearly_month_of_the_year_0'
          click_button 'Submit'
        end

        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe 'all user events - index', js: true do

      describe 'another user events page' do

        before { visit user_events_path(another_user) }

        # Another user not signed in. Signed in - user
        it { should_not have_link(@another_user_event.name) }

      end

      describe 'index page - all user events' do

        before { visit events_path }

        it { should have_link(@another_user_event.name) }
        it { should have_link(@user_event.name) }

        describe 'click on another user event' do

          before { click_link(@another_user_event.name) }

          it { should have_content('Selected day') }
          it { should have_field('Name', disabled: true) }
          it { should have_field('Date', disabled: true) }
          it { should have_field('Repeat', disabled: true) }
          it { should_not have_button('Remove') }
          it { should_not have_button('Submit') }

        end
      end
    end

    describe 'current user events - index', js: true do

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
            fill_event_name_date(name: 'newName')
            select 'never', from: 'Repeat'
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