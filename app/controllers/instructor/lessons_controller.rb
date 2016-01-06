class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to edit_instructor_course_path(current_section.course)
  end

  private

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def require_authorized_for_current_section
    if current_user != current_section.course.user
      return render :text => "Unauthorized", :status => :unauthorized
    end
  end

  def lesson_params
    params.require(:lesson).permit(:title, :transcript)
  end
end
