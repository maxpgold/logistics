class VenuesController < ApplicationController

  def create
    venue = Venue.new(venue_params)
    venue.coordinates = "POINT(#{params[:longitude].to_f.round(6)} #{params[:latitude].to_f.round(6)})"
    if venue.coordinates
      if venue.save
        flash[:success]
        redirect_to edit_camp_path(venue.camp)
      else
        flash[:error] = 'SOMETHING WENT WRONG'
      end
    else
      flash[:error] = 'You must include coordinates'
      redirect_to :back
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name,
                                  :camp_id)
  end
end
