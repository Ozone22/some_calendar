require 'rails_helper'

describe Event do

  before do
    @user = FactoryGirl.create(:user)
    params = { name: 'Test Event', user: @user, start_date: DateTime.current, repeat_type: 'never' }
    @event = Event.new(params)
  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:start_date) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:repeats_every_n_days) }
  it { should respond_to(:repeats_every_n_weeks) }
  it { should respond_to(:repeats_weekly_days_of_the_week) }
  it { should respond_to(:repeats_every_n_months) }
  it { should respond_to(:repeats_every_n_years) }
  it { should respond_to(:repeats_yearly_month_of_the_year) }
  it { should respond_to(:schedule) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @event.name = ' ' }

    it { should_not be_valid }
  end

  describe 'when name is too short' do
    before { @event.name = 'a' }

    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @event.name = 'a' * 201 }

    it { should_not be_valid }
  end


  describe 'when start time not present' do
    before { @event.start_date = nil }

    it { should_not be_valid }
  end

  describe 'when start date in the past' do
    before { @event.start_date = DateTime.yesterday }

    it { should_not be_valid }
  end

  describe 'when user is not present' do
    before { @event.user = nil }

    it { should_not be_valid }
  end

  describe 'user_id should equal event creator' do

    specify { expect(@event.user).to eql(@user) }

  end

  describe 'daily repeat' do
    before { @event.repeat_type = 'daily' }

    it { should_not be_valid }

    describe 'valid data' do
      before { @event.repeats_every_n_days = 2 }

      it { should be_valid }
    end

  end

  describe 'weekly repeat' do
    before { @event.repeat_type = 'weekly' }

    it { should_not be_valid }

    describe 'invalid data' do
      before { @event.repeats_every_n_weeks = 2 }

      it { should_not be_valid }
    end

    describe 'valid data' do
      before do
        @event.repeats_every_n_weeks = 2
        @event.repeats_weekly_days_of_the_week = [1]
      end

      it { should be_valid }
    end
  end

  describe 'monthly repeat' do
    before { @event.repeat_type = 'monthly' }

    it { should_not be_valid }

    describe 'valid data' do
      before { @event.repeats_every_n_months = 2 }

      it { should be_valid }
    end
  end

  describe 'yearly repeat' do
    before { @event.repeat_type = 'yearly' }

    it { should_not be_valid }

    describe 'invalid data' do
      before { @event.repeats_every_n_years = 2 }

      it { should_not be_valid }
    end

    describe 'valid data' do
      before do
        @event.repeats_every_n_years = 2
        @event.repeats_yearly_month_of_the_year = [1]
      end

      it { should be_valid }
    end
  end

  describe 'schedule creation before save(never)' do
    before { @event.save }

    specify { expect(@event.schedule.first).eql?(Date.today) }
  end

  describe 'schedule creation before save(daily)' do
    before do
      @event.repeat_type = 'daily'
      @event.repeats_every_n_days = 2
      @event.save
    end

    specify { expect(@event.schedule.first).eql?(Date.today + 2.days) }
  end
end
