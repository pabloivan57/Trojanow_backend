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
    params.require(:status).permit(:title,
                                   :description,
                                   :anonymous)
  end
end
