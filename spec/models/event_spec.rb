require 'rails_helper'

describe Event do

  before do
    @user = FactoryGirl.create(:user)
    params = { name: 'Test Event', user: @user, start_date: DateTime.current }
    @event = Event.new(params)
  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:start_date) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

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

end
