class UsersController < ApplicationController

  get '/login' do
   erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id

       redirect to "/users/#{@user.id}"
    else
      flash[:errors] = "Invalid credentials, please sign up or try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear

    redirect to '/'
  end

  get '/signup' do
   erb :signup
  end

  post '/users' do
    @user = User.new(params)
    if @user.save   #params[:name] != "" && params[:email] != "" && params[:password] != ""
      #@user = User.create(params)
      session[:user_id] = @user.id
      flash[:message] = "You have successfully created an account #{@user.name}, welcome!"
      redirect to "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
      redirect to '/signup'
    end

  end

   #users show route
  get '/users/:id' do
    @user = User.find_by(id: params[:id])

    erb :'/users/show'
  end
end
