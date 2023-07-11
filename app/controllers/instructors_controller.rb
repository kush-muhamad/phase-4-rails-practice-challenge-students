class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
        def index
            instructors =Instructor.all
            render json: instructors
        end
    
        def create
            instructors =Instructor.create!(instructor_params)
            render json: instructors
        end
    
        def update
            instructors = find_instructor
            instructors.update(instructor_params)
            render json: instructors
        end
    
        def destroy
            instructors = find_instructor
            instructors.destroy
            head :no_content
        end
    
    
    
    
        private
    
        def find_instructor
           instructors =Instructor.find(params[:id])
        end
    
        def instructor_params
            params.permit(:name)
        end
    
        def render_not_found_response
            render json: { error: "Instructor not found" }, status: :not_found
        end
    
        def render_invalid_response(invalid)
            render json: { errors: invalid.record.errors }, status: :unprocessable_entity
        end
    end
    
