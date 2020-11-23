class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.recent
  end

  def new
    @task = Task.new
  end

  def show

  end

  def edit

  end

  def update
    if @task.update(task_params)
      flash[:notice] = "Taskの編集としました！"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def create
    @task = Task.create(task_params)
    if @task.save
    # binding.pry
    flash[:notice] = 'Taskの投稿に成功しました！'
    redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Taskを削除しました！"
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :dead_line)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
