class AdminController < ApplicationController
  before_action :check_user_admin
  
  def index    
  end

end
