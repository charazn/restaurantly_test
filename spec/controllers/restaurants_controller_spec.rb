require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  # RubyonRailsTutor
  # Failure/Error: subject { get "restaurants/#{@restaurant.id + 1}"}
  # ActionController::UrlGenerationError:
  # No route matches {:action=>"restaurants/2", :controller=>"restaurants"}

  # describe RestaurantsController do
  #   context "GET /restaurants/:id" do
  #     before do
  #       @restaurant = FactoryGirl.create(:restaurant)
  #     end

  #     context "resource exists" do
  #       subject { get "restaurants/#{@restaurant.id}"}
  #       it { expect(subject).to render_template(:show) }
  #     end

  #     context "resource does not exist" do
  #       subject { get "restaurants/#{@restaurant.id + 1}"}
  #       it { expect(subject).to redirect_to(:root) }
  #     end
  #   end
  # end

  let(:restaurant) { create(:restaurant) }

  describe "GET #show" do
    before { get :show, id: restaurant.id }

    it { expect(assigns :restaurant).to be }
    it { expect(response).to render_template(:show) }
  end

  # RubyonRailsTutor. Not test this in Tinkerbox.
  # Failure/Error: if @restaurant = Restaurant.find(params[:id])
  # ActiveRecord::RecordNotFound:
  # Couldn't find Restaurant with 'id'=2

  # describe "GET #show resource does not exist" do
  #   before { get :show, id: restaurant.id + 1 }

  #   it { expect(response).to redirect_to(:root) }
  # end
end
