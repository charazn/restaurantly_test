class RestaurantsController < ApplicationController
  def show
    if @restaurant = Restaurant.find(params[:id])
      render :show
    else
      flash[:warning] = "That restaurant does not exist."
      redirect_to root_path
    end
  end
end
