class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
      if params[:sort_expired] == "true"
        @tasks = Task.over
      elsif params[:sort_expired] == "false"
        @tasks = Task.recent
        binding.pry
      end
    if params[:search_title].present? && params[:search_status].present?
      @tasks = Task.search_title(params[:search_title]).search_status(params[:search_status])
      # @tasks = Task.where('title LIKE ?', "%#{params[:title]}%").where(status: params[:search_status])
    elsif params[:search_title].present?
      @tasks = Task.search_title(params[:search_title])
      # @tasks = Task.where('title LIKE ?', "%#{params[:search_title]}%")
    elsif params[:search_status].present?
      @tasks = Task.search_status(params[:search_status])
      # @tasks = Task.where(status: params[:search_status])
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
    params.require(:task).permit(:title, :content, :dead_line, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
