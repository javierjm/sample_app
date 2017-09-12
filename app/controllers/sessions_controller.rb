class SessionsController < ApplicationController
  def new
  end
  #create
  def create 
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password]) 
  		#Log the user in and redirect to the user's show page 
  		log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#  		redirect_to users_url user.  id
  		#redirect_to @user
      redirect_back_or user

  	else
  		#Create error message 
     	flash.now[:danger] = 'Invalid email/password combination'
  		render 'new' 
  	end
  end

  #destroy
  def destroy 
    log_out if logged_in? 
    redirect_to root_url
  end

end
