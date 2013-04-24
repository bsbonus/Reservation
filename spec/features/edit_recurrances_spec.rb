require 'spec_helper'


feature 'User can edit recurrances' do
	before do
	  	reserv = FactoryGirl.create(:reservation, id: 10, recur: "Weekly", recurrance_duration: 4)
	    visit '/sessions/create' 
		visit '/reservations'
		click_link(reserv.id)
	end

	context 'User wants to edit only one specific recurrance' do

	end

	context "User wants to edit multiple associated recurrances" do

	  it "User clicks on the 'all' checkbox to edit all recurrances" do
	  	
	  end

	  it "User clicks on multiple checkboxes" do
	  end 
	end

	
end