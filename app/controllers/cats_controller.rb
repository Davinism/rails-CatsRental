class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat_rental_requests = CatRentalRequest.where(cat_id: params[:id])
    @cat = Cat.find_by_id(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
  end

  def create
    @cat = Cat.new(cats_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      @cat.errors.full_messages status: :unprocessable_entity
    end
  end

  private
  def cats_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end
end
