class UsersController < ApplicationController

  get '/login' do
   erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])

    if @user.authenticate(params[:password])
       session[:user_id] = @user.id

       redirect to "users/#{@user.id}"
    else

    end
  end
   #users show route
  get '/users/:id' do
    "users show route"
  end
end
