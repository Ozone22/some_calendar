require 'rails_helper'

describe EventInstance do

  let(:end_date) { Date.today + 1.week }
  before { @event = FactoryGirl.create(:event, start_date: Date.today, repeat_type: 'daily', repeats_every_n_days: 2) }

  describe 'single occurrence' do
    before do
      @single_event_occurrences = EventInstance.single_event_occurrences(@event, end_date: end_date)
    end

    specify { expect(@single_event_occurrences.length).to be > 1 }
  end

  describe 'occurrences' do
    before do
      @user = FactoryGirl.create(:user)
      @event.update_attributes(user_id: @user.id)
    end
    specify { expect(EventInstance.occurrences(@user, end_date).length).to be > 1 }
  end
end