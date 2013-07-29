require 'spec_helper'


feature 'User can edit recurrances' do

	context 'User wants to edit only one specific recurrance' do
		
		it "User changes the room" do
			reserv = FactoryGirl.create(:reservation, id: 10, room: "Interview1", recur: "Weekly", recurrance_duration: 4)
		    visit '/sessions/create' 
			visit '/reservations?limit=4'
			save_and_open_page
			click_link(12)
			save_and_open_page
			#page.select 'Ops', :from => 'reservation_room'
			#select (page.find_by_id('reservation_room').find('option[value="Ops"]') )
			 #find("option[value='Ops']").click
			#find("option[value='Ops']").select_option
			#find("option[value='Ops']").set(true)
			#page.find_by_id('reservation_room').find("option[value='Ops']").click
			page.find("reservation_room")
			#page.first(:css, ".reserv_updates").set(true)
			page.click_button('UpdateSelectedButton')
			save_and_open_page
			page.should have_content("Ops")
		end
	end

	context "User wants to edit multiple associated recurrances" do

	  it "User clicks on the 'all' checkbox to edit all recurrances" do

	  end

	  it "User clicks on multiple checkboxes" do
	  end 

	  it "User clicks on 'this reservation' checkbox" do
	  end
	end

	
end