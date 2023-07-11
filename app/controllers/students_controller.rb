class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    def index
        students = Student.all
        render json: students
    end

    def create
        students = Student.create!(student_params)
        render json: students
    end

    def update
        student = find_student
        student.update(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end




    private

    def find_student
        student = Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_invalid_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
