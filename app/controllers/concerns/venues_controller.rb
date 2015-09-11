class VenuesController < ApplicationController
  def create
    venue = Venue.new(venue_params)
    venue.coordinates = "POINT(#{params[:latitude]} #{params[:longitude]}"
    if venue.save
      flash[:success] = "Venue #{venue.name} successfully added"
      redirect_to edit_camp_path(venue.camp)
    else
      flash[:error] = 'Something went wrong'
    end
  end

  private

    def venue_params
      params.require(:venue).permit(:name,
                                    :camp_id)
    end
end
