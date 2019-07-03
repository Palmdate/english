class HomeController < ApplicationController
  before_action :check_user
  
  def index
    if current_user.email == "admin@en4pr.com"
      redirect_to  admin_index_path
    end
    
  end

  def course
    if params[:status_id]
      status = Course.all.find_by_id(params[:status_id])
      status.update(:status => "Done")
    end
  end
end
