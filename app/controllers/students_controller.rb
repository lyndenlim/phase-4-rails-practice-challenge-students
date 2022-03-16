class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    students = Student.all
    render json: students
  end

  def show
    if params[:id]
      render json: find_student
    end
  end

  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def update
    find_student.update!(student_params)
    render json: find_student, status: :ok
  end

  def destroy
    find_student.destroy
    head :no_content
  end

  private

  def find_student
    Student.find(params[:id])
  end

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
