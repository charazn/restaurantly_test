class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.all
  end

  def show
    if @restaurant = Restaurant.find_by(id: params[:id])
      render :show
    else
      flash[:warning] = "That restaurant does not exist."
      redirect_to root_path
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      flash[:notice] = "Restaurant successfully created"
      redirect_to restaurant_path @restaurant
    else
      flash[:error] = "Restaurant is invalid" # @restaurant.errors.inspect
      render :new
    end
  end

  def edit
    if @restaurant = Restaurant.find_by(id: params[:id])
      render :edit
    else
      flash[:warning] = "That restaurant does not exist."
      redirect_to root_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant successfully updated"
      redirect_to restaurant_path @restaurant
    else
      flash[:error] = "Restaurant is invalid"
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "Restaurant is successfully destroyed"
    redirect_to root_path
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :address)
    end
end
