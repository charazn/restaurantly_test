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
    context "restaurant exists" do
      before { get :show, id: restaurant.id }

      it { expect(assigns :restaurant).to be }
      it { expect(response).to render_template(:show) }
    end

    context "restaurant does not exist" do
      before { get :show, id: restaurant.id + 1 }

      it { expect(assigns :restaurant).to be_nil } # or .not_to be
      it { expect(response).to redirect_to :root }
    end
  end

  # RubyonRailsTutor. Not test this in Tinkerbox.
  # Failure/Error: if @restaurant = Restaurant.find(params[:id])
  # ActiveRecord::RecordNotFound:
  # Couldn't find Restaurant with 'id'=2

  # describe "GET #show resource does not exist" do
  #   before { get :show, id: restaurant.id + 1 }

  #   it { expect(response).to redirect_to(:root) }
  # end

  describe "GET #new" do
    before { get :new }

    it { expect(assigns :restaurant).to be }
    it { expect(response).to render_template(:new) }
  end

  describe "POST #create" do
    before { post :create, restaurant: restaurant_params }

    context "with valid params" do
      let(:restaurant_params) { attributes_for(:restaurant) }

      it { expect(assigns :restaurant).to be_persisted }
      it { expect(response).to redirect_to restaurant_path(Restaurant.last) }
    end

    context "with invalid params" do
      let(:restaurant_params) { attributes_for(:restaurant, :invalid) }

      it { expect(assigns :restaurant).not_to be_persisted }
      it { expect(response).to render_template :new }
    end
  end

  describe "GET #edit" do
    context "restaurant exists" do
      before { get :edit, id: restaurant.id }

      it { expect(assigns :restaurant).to be }
      it { expect(response).to render_template :edit }
    end

    context "restaurant does not exist" do
      before { get :edit, id: restaurant.id + 1 }

      it { expect(assigns :restaurant).not_to be }
      it { expect(response).to redirect_to :root }
    end
  end

  describe "PATCH #update" do
    before { patch :update, restaurant: restaurant_params, id: restaurant.id }

    context "with valid params" do
      let(:restaurant_params) { attributes_for(:restaurant, :update) }

      it { expect(assigns :restaurant).to be_valid }
      it { expect(response).to redirect_to restaurant_path(assigns :restaurant) }
    end

    context "with invalid params" do
      let(:restaurant_params) { attributes_for(:restaurant, :invalid) }

      it { expect(assigns :restaurant).not_to be_valid }
      it { expect(response).to render_template :edit }
    end
  end

  describe "DELETE #destroy" do
    let!(:restaurant) { create(:restaurant) }
    before { delete :destroy, id: restaurant.id }

    it { expect(assigns :restaurant).to be_destroyed }
    it { expect(response).to redirect_to root_path }
  end
end
