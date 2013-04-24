require 'spec_helper'


feature 'Visitor can log-in with GOOD gmail' do

    context 'is logged into GOOD via gmail' do
      it "sees the logged-in screen" do
        visit '/sessions/create'
        visit '/reservations'
        page.should have_content('Welcome')
      end

      it "can sign out of the app" do
        visit '/sessions/create'
        visit '/reservations' 
        click_link('Logout') 
        page.should have_content('Signin Sign In')
      end
    end

    context 'is not logged into GOOD via gmail' do 
      it "sees the login prompt" do 
        visit '/reservations/index'
        page.should have_content('Signin Sign In')
      end

      it "can login to the app" do
        visit '/reservations/index'
        click_link('Signin')
        current_path.should eq('/')
      end
    end

end