require 'spec_helper'

describe 'User tries to edit new reservation' do
	before do
		reserv = FactoryGirl.create(:reservation, id: 10)
	    visit '/sessions/create' 
		visit '/reservations'
		click_link(reserv.id)
	end

	it "page renders the create reservation '_form' partial" do
		response.body.should render_template(:partial => 'reservations/_form')
	end

	it "page renders the '_delete_options' partial" do
		page.should render_template(:partial => 'reservations/_delete_options')
	end 

	it "should only display the 'Delete Options' button" do
		page.should have_link("Delete Options")
		page.has_css?('li', :text => 'Horse', :visible => true)
	end

	it "should display a checkbox input to delete that reservation" do 
		click_link('Delete Options')
		page.should have_selector("input[type=checkbox]")
		page.should have_selector("input[id='10']")
	end

	it "should display a link to 'delete' " do 
		click_link('Delete Options')
		page.should have_selector("a[href='/reservations/10']")
		page.should have_selector("a[id='delete_link']")
	end

end