class CourseController < ApplicationController
  before_action :set_course, only: [:edit, :update, :destroy]
  before_action :check_user
  
  def create
  end

  def store
    @course = Course.new({:skill => params[:skill], :quality => params[:quality], :status => "Not Starting", :day_id => params[:day_id], :user_id => current_user.id})
    @course.save
    redirect_to home_course_path
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to home_course_path
    else
      redirect_to edit_user_path(@course)
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    redirect_to home_course_path
  end
  
  private
  def set_course
    @course = Course.find(params[:id])
  end
 
  def course_params
    params.require(:course).permit(:status, :skill, :quality, :user_id, :day_id)
  end
end
