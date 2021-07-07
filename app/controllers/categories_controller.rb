class CategoriesController < ApplicationController
  rescue_from Exception, with: :handle_exception
  before_action :set_category, only: [:update, :destory, :show]

  def index
    render json: Category.all, only: [:id, :name]
  end

  def show
    render json: @category
  end

  def create
    render json: Category.create(category_params), status: :created
  end

  def update
    if @category.update(category_params)
      render json: category, status: :ok
    else
      render json: { error: "Failed to update category" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      render status: :no_content
    else
      render json: { error: "Failed to destroy category" }, status: :unprocessable_entity
    end
  end

  private

  def handle_exception(e)
    render json: { error: e }, status: :not_found
  end

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
