class PlacementsController < ApplicationController
  before_action :find_placement, only: [:show, :update]

  def index
    @classrooms = Classroom.all
    @placements = Placement.all

    # If the request was for a particular classroom, filter for it
    @classroom_id = params[:classroom_id]
  end

  def create
    @placement = Placement.build(classroom_id: params[:classroom_id])
    if @placement.save()
      if params[:run_solver]
        @placement.solve
      end
      redirect_to placement_path(@placement)
    else
      flash[:status] = :failure
      flash[:message] = "Could not create placement"
      flash[:errors] = @placement.errors.messages
      redirect_back
    end
  end

  def show
  end

  def update
    begin
      @placement.set_pairings(placement_update_params['pairings'])

      puts "Transaction success!"
      render json: {
        errors: []
      }
    rescue ActiveRecord::RecordInvalid => invalid
      puts "Rendering bad request"
      render status: :bad_request, json: {
        errors: invalid.record.errors.messages
      }
    end
  end

private
  def find_placement
    begin
      @placement = Placement.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, content: false
    end
  end

  def placement_update_params
    params.require(:placement).permit(pairings: [:company_id, :student_id])
  end
end
