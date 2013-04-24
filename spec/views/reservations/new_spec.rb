require 'spec_helper'

describe 'User tries to create new reservation' do
	it "page renders the create reservation form" do
	    visit '/sessions/create' 
		visit '/reservations'
		click_link('Create Reservation')
		response.body.should render_template(:partial => 'reservations/_form')
	end 
end