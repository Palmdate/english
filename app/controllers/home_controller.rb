class HomeController < ApplicationController
  def index
    unless current_user
      redirect_to login_path
    end
  end

  def course
    if params[:status_id]
      status = Course.all.find_by_id(params[:status_id])
      status.update(:status => "Done")
    end
  end
end
