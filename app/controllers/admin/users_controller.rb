class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:index, :new, :create,]
  def index
    @users = User.all
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
                                :password_confirmation)
 end
end
