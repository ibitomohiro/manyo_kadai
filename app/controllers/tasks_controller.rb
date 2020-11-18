class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    # binding.pry
    redirect_to new_task_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end

end
