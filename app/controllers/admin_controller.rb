class AdminController < ApplicationController
  before_action :check_user_admin
  
  def index    
  end

  def report
    last_report = ReadAloudReport.where(user_id:current_user.id).order('updated_at DESC').first
    if params[:rate].to_i >= 60
      
      if last_report != nil && last_report.sentence.to_s == params[:sentence]
        last_report.update(:percent => params[:rate])
        render json: { status: 'update', message: "Your accuracy need larger than 60% " }
      else
        report = ReadAloudReport.new(:user_id => current_user.id,
                                     :sentence => params[:sentence],
                                     :percent => params[:rate],
                                     :result => params[:result])
        if report.save!
          render json: { status: 'success', message: "Saved" }
        else
          render json: { status: 'errors', message: "Occured errors!" }
        end
        
      end
      
    else
      render json: { status: 'error', message: "Your accuracy need larger than 60% " }
    end      
  end
end
