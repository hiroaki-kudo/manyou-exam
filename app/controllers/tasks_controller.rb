class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(end_date: :desc).page(params[:page]).per(3)
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(3)
    end
    if params[:sort_ranked]
      @tasks = current_user.tasks.order(rank: :desc).page(params[:page]).per(3)
    end
    if params[:search].present? && params[:status].present?
      @tasks = current_user.tasks.search_name_status(params[:search],params[:status]).page(params[:page]).per(3)
      # @tasks = Task.where("name LIKE ?", "%#{params[:search]}%")
      #               .where(status: params[:status])
    elsif params[:search].present?
      @tasks = current_user.tasks.search_name(params[:search]).page(params[:page]).per(3)
    elsif params[:status].present?
      @tasks = current_user.tasks.search_status(params[:status]).page(params[:page]).per(3)
    end
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end
  def edit

  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end
  def show
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end
  private
  def task_params
    params.require(:task).permit(:name, :detail, :end_date, :status, :rank, label_ids: [] )
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
