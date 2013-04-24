require 'spec_helper'

describe SessionsController do 
  subject { controller }

  describe "GET 'create'" do
	it "returns http success" do
    get 'create'
	  response.should redirect_to root_url
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      session = session.stub(:id)
      delete 'destroy', id: session
      response.should redirect_to reservations_url
    end
  end

end