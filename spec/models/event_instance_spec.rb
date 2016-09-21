require 'rails_helper'

describe EventInstance do

  let(:end_date) { Date.today + 1.week }
  let(:event) { FactoryGirl.create(:event, repeat_type: 'daily', repeats_every_n_days: 2) }

  describe 'single occurrence' do
    specify { expect(EventInstance.single_event_occurrences(event, end_date: end_date).length).to be > 1 }
  end
end