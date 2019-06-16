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
      flash[:message] = "Task successfully created"
      @task = Task.create(content: params[:content], user_id: current_user.id)

      redirect to "/tasks/#{@task.id}"
    else
      flash[:errors] = "Please try again"
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
      if @task.user == current_user && params[:content] != ""

         @task.update(content: params[:content])
         flash[:message] = "Successfully updated"
         redirect to "/tasks/#{@task.id}"
      else
         redirect to "/users/#{@task.id}"
      end
    else
      redirect to '/'
    end
  end

  delete '/tasks/:id' do
    find_task
    if @task.user == current_user
      @task.destroy
      flash[:message] = "You have successfully deleted that entry"
      redirect to '/tasks'
    else
      redirect to '/tasks'
    end
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
