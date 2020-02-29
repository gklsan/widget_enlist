class WidgetsController < ApplicationController
  include Widget

  def index
    @widgets = public_widgets
  end
end
