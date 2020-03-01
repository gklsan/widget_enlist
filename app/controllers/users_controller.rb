class UsersController < ApplicationController
  include User
  include Authentication

  def show
    @user = user
    @widgets = user_widgets
  end

  def create
    @user = create_user
    if @user
      redirect_to user_path(@user['id']), notice: 'Signup done!!!'
    else
      redirect_to root_path, alert: 'Could not process your request'
    end
  end

  def login
    alert_notice = user_login ? {notice: 'Login done!!!'} : {alert: 'Could not process your request'}
    redirect_to root_path, alert_notice
  end

  def logout
    alert_notice = user_logout ? {notice: 'Logout successfully!!!'} : {alert: 'Could not process your request'}
    redirect_to root_path, alert_notice
  end

  def reset_password
    txt = reset_user_password
    alert_notice = txt ? {notice: txt} : {alert: 'Could not process your request'}
    redirect_to root_path, alert_notice
  end

  def change_password
    alert_notice = change_user_password ? {notice: 'Password changed!!!'} : {alert: 'Could not process your request'}
    redirect_to root_path, alert_notice
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:first_name, :last_name, :email, :password, :image_url, :current_password, :new_password)
  end
end
