class StatusesController < ApiController

  def create
    status = current_user.statuses.build(status_params)
    if status.save
      respond_with(status, status: :created, location: nil)
    else
      respond_with(status.errors, status: :unprocessable_entity, location: nil)
    end
  end

  private

  def status_params
    params[:status][:location_attributes]    = params[:status][:location]    if params[:status][:location]
    params[:status][:environment_attributes] = params[:status][:environment] if params[:status][:environment]
    params.require(:status).permit(:title,
                                   :description,
                                   :anonymous,
                                   :status_type,
                                   location_attributes: [:latitude, :longitude],
                                   environment_attributes: [:temperature])
  end
end
