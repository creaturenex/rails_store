class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy]
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @products = Product.all
  end

  def show
  end

  # create is a two step process, new then save which will check for errors via validations if present
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  # this sanitizes the url input and makes sure we only have the relevant keys
  def product_params
    params.expect(product: [ :name, :description, :featured_image, :inventory_count ])
  end
end
