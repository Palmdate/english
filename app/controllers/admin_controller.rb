class AdminController < ApplicationController
  def index
    
    
  end

  def report
    if params[:rate].to_i >= 60
      report = ReadAloudReport.new(:user_id => current_user.id,
                                   :sentence => params[:sentence],
                                   :percent => params[:rate],
                                   :result => params[:result])
      if report.save!
        render json: { status: 'success', message: "Saved" }
      else
        render json: { status: 'errors', message: "Occured errors!" }
      end
      
    else
      render json: { status: 'error', message: "Your accuracy need larger than 60% " }
    end
      

  end
end
