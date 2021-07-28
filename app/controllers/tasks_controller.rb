class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.order(end_date: :desc)
    else
      @tasks = Task.order(created_at: :desc)
    end
    if params[:search].present? && params[:status].present?
      @tasks = Task.search_name_status(params[:search],params[:status])
      # @tasks = Task.where("name LIKE ?", "%#{params[:search]}%")
      #               .where(status: params[:status])
    elsif params[:search].present?
      @tasks = Task.search_name(params[:search])
    elsif params[:status].present?
      @tasks = Task.search_status(params[:status])
    end
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:name, :detail, :end_date, :status)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
