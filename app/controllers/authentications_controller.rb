class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def show
    @authentication = Authentication.find(params[:id])
  end

  def destroy
    Authentication.find(params[:id]).delete
    redirect_to :index
  end
end
