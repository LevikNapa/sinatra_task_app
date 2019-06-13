class TasksController < ApplicationController

  get '/tasks' do
    @tasks = Task.all
    erb :'/tasks/index'
  end

  
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

  get '/tasks/:id' do
    find_task
    erb :'/tasks/show'
  end

  get '/tasks/:id/edit' do
    find_task
    if logged_in?
      if @task.user == current_user
         erb :'/tasks/edit'
      else
         redirect to "/users/#{@task.id}"
      end
    else
     redirect to '/'
    end
  end

  patch '/tasks/:id' do
    find_task
    if logged_in?
      if @task.user == current_user

         @task.update(content: params[:content])
         redirect to "/tasks/#{@task.id}"
      else
         redirect to "/users/#{@task.id}"
      end
    else
      redirect to '/'
    end
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
