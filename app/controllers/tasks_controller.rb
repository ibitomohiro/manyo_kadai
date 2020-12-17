class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  def index
    # @tasks = Task.all
    @tasks = Task.page(params[:page]).per(5)
    if params[:sort_expired] == "true"
      @tasks = @tasks.over
    elsif params[:sort_expired] == "false"
      @tasks = @tasks.recent
    end

    if params[:task].present?
      @tasks = @tasks.search_title(params[:task][:title])
      @tasks = @tasks.search_status(params[:task][:status])
      if params[:task][:priority].present?
        @tasks = @tasks.search_priority(params[:task][:priority])
      end
    end
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
      flash[:notice] = "Taskの編集をしました！"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def create
    @task = Task.create(task_params)
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :dead_line, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
