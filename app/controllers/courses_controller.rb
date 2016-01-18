class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      if course_params[:image].present?
        render :crop
      else
        redirect_to @course, notice: 'Successfully updated'
      end
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :price, :image, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
