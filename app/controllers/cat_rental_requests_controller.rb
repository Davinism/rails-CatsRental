class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by_id(params[:id])
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
  end

  def edit
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.find_by_id(params[:id])
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_requests_params)

    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      @cat_rental_request.errors.full_messages status: :unprocessable_entity
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!

    redirect_to :back
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!

    redirect_to :back
  end

  private
  def cat_rental_requests_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
