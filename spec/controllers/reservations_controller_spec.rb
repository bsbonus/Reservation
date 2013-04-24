require 'spec_helper'

describe ReservationsController do
	subject { controller }
	
	describe "GET 'index'" do
	  it "returns http success" do
	    get 'index'
	    response.should be_success
	  end
  	end

  	describe "POST 'create'" do
	  it "returns http success" do
	    post 'create', reservation: FactoryGirl.attributes_for(:reservation)
	    response.should be_suceess
	  end
  	end

  	describe "GET 'new'" do
	  it "returns http success" do
	    get 'new'
	    response.should be_success
	  end
  	end

  	describe "PUT 'edit'" do
	  it "returns http success" do
	  	reservation = FactoryGirl.create(:reservation)
	    put 'edit', id: reservation
	    response.should be_success
	  end
  	end

    describe "GET 'show'" do
	  it "returns http success" do
	  	reservation = FactoryGirl.create(:reservation)
	    get 'show', id: reservation
	    response.should be_success 
	  end
  	end

  	describe "DELETE 'destroy'" do
	  it "returns http success" do
	 	reservation = FactoryGirl.create(:reservation)   
	    delete 'destroy', id: reservation
	    response.should be_success
	  end
  	end
end
