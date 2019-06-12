class TasksController < ApplicationController
  get '/tasks/new' do
    erb :'/tasks/new'
  end

  post '/tasks' do
    if !logged_in?
      redirect to '/'
    end

    if params[:content] != ""
      @task = Task.create(content: params[:content], user_id: current_user.id)

      redirect to "/tasks/#{@task.id}"
    else
      redirect to '/tasks/new'
    end
  end
  
end
