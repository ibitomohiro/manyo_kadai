class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_require
  def index
    @tasks = current_user.tasks
    @tasks = @tasks.page(params[:page]).per(5)
    # @tasks = @tasks.joins(:labels).where(labels: {id: params[:label_id]}) if params[:label_id].present?
    if params[:sort_expired] == "true"
      @tasks = @tasks.over
    elsif params[:sort_expired] == "false"
      @tasks = @tasks.recent
    end

    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
      @tasks = @tasks.search_title(params[:task][:title])
      @tasks = @tasks.search_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.search_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = @tasks.search_status(params[:task][:status])
      elsif params[:task][:label_id].present?
        @labelling = Labelling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @labelling)
      end
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
      flash[:notice] = I18n.t('notice.task_is_updated')
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def create
    #current_userのuser_idを入れる
    @task = current_user.tasks.new(task_params)
    if @task.save
    flash[:notice] = I18n.t('notice.task_is_posted')
    redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = I18n.t('notice.task_is_deleted')
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :dead_line, :status, :priority, label_ids: [])
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
