class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, :only => [:edit]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to edit_instructor_course_path(@course)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def edit
    @section = Section.new
  end

  private

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def require_authorized_for_current_course
    if current_user != current_course.user
      return render :text => "Unauthorized", :status => :unauthorized
    end
  end

  def course_params
    params.require(:course).permit(:title, :description, :price, :image)
  end
end
