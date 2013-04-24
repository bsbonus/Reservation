require 'spec_helper'


feature 'User can delete all instances of a recurrance' do

	context "clicks on the 'all' checkbox" do
		it "should delete that reservation" do
		    visit '/sessions/create' 
			visit '/reservations'
			reserv = FactoryGirl.create(:reservation, id: 10)
			Reservation.count.should eq(1)
			visit '/reservations'
			click_link(reserv.id.to_s)			
			all("input[type='checkbox']")[0].set(true)
			click_button("Delete Selected")
			Reservation.count.should eq(0)
		end

		it "should delete all associated reservations" do
		    visit '/sessions/create' 
			visit '/reservations'
			reserv = FactoryGirl.create(:reservation, id: 10, recur: "Weekly", recurrance_duration: '4')
			visit '/reservations?limit=5'
			Reservation.count.should eq(5)
			Recurrance.count.should eq(1)
			click_link(reserv.id.to_s)			
			all("input[type='checkbox']")[-1].set(true)
			click_button("Delete Selected")
			Reservation.count.should eq(0)
			Recurrance.count.should eq(0)
		end
	end

	context "clicks on a given reservation checkbox" do

		it "should delete only that reservation" do
			visit '/sessions/create' 
			visit '/reservations'
			reserv = FactoryGirl.create(:reservation, id: 10, recur: "Weekly", recurrance_duration: '4')
			visit '/reservations?limit=4'
			Reservation.count.should eq(5)
			click_link(reserv.id.to_s)			
			all("input[type='checkbox']")[-2].set(true) 
			click_button("Delete Selected")
			Reservation.count.should eq(4)
		end
	end

	
end
