require 'spec_helper'

describe Recurrance do
	context 'is a recurring reservation' do 
		it "has a valid factory" do 
			FactoryGirl.build(:recurrance).should be_valid
		end

		context 'is a weekly reservation' do
			it "will create a recurrance reservation that occurs weekly and has parent values" do
				reserv_base = FactoryGirl.create(:reservation, recur: "Weekly", recurrance_duration: 4)
				recurrance = Recurrance.find_by_recur("Weekly")
				recurrance.recur.should eq(reserv_base.recur)
				recurrance.duration.should eq(reserv_base.recurrance_duration)
				recurrance.id.should eq(reserv_base.id)
				recurrance.room.should eq(reserv_base.room)
				recurrance.start_date.should eq(reserv_base.date)
			end
		end

		context 'it is a monthly reservation' do 
			it 'will create a recurrance reservation that occurs monthly and has parent values' do
				reserv_base = FactoryGirl.create(:reservation, recur: "Monthly", recurrance_duration: 4)
				recurrance = Recurrance.find_by_recur("Monthly")
				recurrance.recur.should eq(reserv_base.recur)
				recurrance.duration.should eq(reserv_base.recurrance_duration)
				recurrance.id.should eq(reserv_base.id)
				recurrance.room.should eq(reserv_base.room)
				recurrance.start_date.should eq(reserv_base.date)				
			end
		end
	end
end