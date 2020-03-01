class WidgetsController < ApplicationController
  include User
  include Authentication
  include Widget

  before_action :authenticate_user, only: %i[create update edit destroy new]

  def index
    @widgets = if params[:me].to_s == 'true'
                 @my_widgets = true
                 current_user_widgets
               else
                 public_widgets
               end
  end

  def new; end

  def create
    create_widget
    redirect_to widgets_path(me: true), notice: 'Widget created successfully.'
  end

  def update
    update_widget
    redirect_to widgets_path(me: true), notice: 'Widget updated successfully.'
  end

  def edit
    @widget = params[:widget]
  end

  def destroy
    remove_widget
    redirect_to root_path(me: true), notice: 'Widget removed successfully.'
  end

  private

  def widget_params
    params.fetch(:widget, {}).permit(:name, :id, :description, :kind)
  end
end
