class SessionsController < ApplicationController
  def create
  	auth = request.env["omniauth.auth"]
    if auth
      session[:uid] = auth["uid"]
      session[:name] = auth["info"]["name"]
  	end
    session[:official] = true
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:official] = false
    reset_session
    redirect_to reservations_url, :notice => "Signed Out!"
  end
end
