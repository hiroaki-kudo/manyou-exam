class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:index, :new, :create,]
  before_action :user_admin, only: [:index]
  def index
    @users = User.all.includes(:tasks)
    # if params[:id]
    #   user = User.find(params[:id])
    #   binding.pry
    #   user.admin = true
    #   user.save
    #   flash[:aleat] = 'ロールを付与しました'
    # end
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    @tasks = User.find(params[:id]).tasks
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice:"タスクを削除しました！"
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
  end
  def user_admin
    @users = User.all
    if current_user.admin == false
      flash[:aleat] = '管理者以外はアクセスできません'
      redirect_to root_path
    else
      render action: "index"
    end
  end
end
