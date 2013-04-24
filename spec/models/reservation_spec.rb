require 'spec_helper'

describe Reservation do
	it "has a valid factory" do
		FactoryGirl.build(:reservation).should be_valid
	end

	context "validations" do

	  subject { FactoryGirl.create(:reservation) }
	  it { should validate_presence_of(:room) } 
	end

	it "must have a date selectd" do
	 @reservation = FactoryGirl.build(:reservation, date: nil)
	 @reservation.should be_invalid 
	end

    it "cannot be made in the past" do
	  @reservation = FactoryGirl.build(:reservation, date: Date.today - 1)
	  @reservation.should be_invalid
    end

    it "must set time_in earlier than time_out" do
	  @reservation = FactoryGirl.build(:reservation, time_in: Time.now, 
									 time_out: Time.now - 1.hour)
	  @reservation.should be_invalid
    end	  

    it "can't conflict with older reservations" do 
	  @reservation = FactoryGirl.build(:reservation, time_in: Time.now, 
									  time_out: Time.now + 1.hour)
      @reservation2 = FactoryGirl.build(:reservation, time_in: Time.now)
	  @reservation2.should be_invalid
    end

    it "must have a minimum duration of 15 minutes" do
	  @reservation = FactoryGirl.build(:reservation, time_in: Time.now, 
									  time_out: Time.now + 14.minutes)
	  @reservation.should be_invalid								      	
    end

end