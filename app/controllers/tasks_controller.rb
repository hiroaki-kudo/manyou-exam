class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all
      @tasks = Task.order(end_date: :desc)
    else
      @tasks = Task.all
      @tasks = Task.order(created_at: :desc)
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
    params.require(:task).permit(:name, :detail, :end_date)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
