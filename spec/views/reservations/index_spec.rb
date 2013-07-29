require 'spec_helper'

describe 'rendering the index' do 

	it "page displays the calendar" do
	    visit '/sessions/create' 
		visit '/reservations'
		response.body.should render_template(:partial => 'reservations/_calendar')
	end

	it 'page displays logout prompt' do 
		visit '/sessions/create' 
		visit '/reservations'
		page.should have_link('Logout', '/sessions/destroy') 	
	end

	it "calendar renders reservations details" do
		reserv = FactoryGirl.create(:reservation)
		id = reserv.id.to_s
		details = reserv.room + reserv.time_in.strftime("%l:%M %p") + reserv.time_out.strftime("%l:%M %p")
		visit '/sessions/create' 
		visit '/reservations'
		page.should have_selector('#' + id )

	end

	it "calendar does not render reservations outside the default range" do
		two_week_later = Date.today + 21.days
		reserv_two_week_later = FactoryGirl.create(:reservation, date: two_week_later)
		id = reserv_two_week_later.id.to_s
		visit '/sessions/create' 
		visit '/reservations'
		page.should_not have_selector('#' + id )
	end

	it "calendar will render additional reservations if limit is adjusted" do 
		later = Date.today + 21.days
		reserv_later = FactoryGirl.create(:reservation, date: later)
		id = reserv_later.id.to_s
		visit '/sessions/create' 
		visit '/reservations?limit=6'
		page.should have_selector('#' + id )
	end

	it "can add another week" do 
		visit '/sessions/create' 
		visit '/reservations'
		today = Date.today
		week_later = (today + 14.days).strftime("%B %e")
		click_link('see another week')
		page.should have_selector('div', text: week_later)
	end

	it "makes my reservations visibly noticeable in some way" do 
		reserv = FactoryGirl.create(:reservation, :createdby => "brian@goodinc.com")
		id = reserv.id.to_s
		visit '/sessions/create' 
		visit '/reservations'
		reservation = find("#" + id)
		reservation['class'].should eq("mine")
	end
end