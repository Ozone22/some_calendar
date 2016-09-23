require 'rails_helper'

describe FreeDayInstance do

  let(:end_date) { Date.today + 1.week }
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }

  describe 'free days between users' do

    let(:free_days) { FreeDayInstance.free_days_between_users(user, another_user, end_date) }

    before do
      FactoryGirl.create(:event, repeat_type: 'daily', repeats_every_n_days: 2, user: user)
      @event = FactoryGirl.create(:event, repeat_type: 'daily', repeats_every_n_days: 4, user: another_user)
    end

    specify { expect(free_days.length).to be > 1 }

    describe 'free days not exist' do
      before { @event.update_attributes(repeats_every_n_days: 2) }

      specify { expect { free_days.length }.eql?(0) }
    end
  end
end