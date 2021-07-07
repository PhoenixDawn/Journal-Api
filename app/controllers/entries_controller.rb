class EntriesController < ApplicationController
  # before_action :authenticate

  rescue_from Exception, with: :handle_exception
  before_action :set_entry, only: [:update, :destory, :show]

  def index
    render json: Entry.all.order(updated_at: :desc)
  end

  def show
    render json: @entry
  end

  def create
    render json: Entry.create(entry_params), status: :created
  end

  def update
    if @entry.update(entry_params)
      render json: entry, status: :ok
    else
      render json: { error: "Failed to update entry" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @entry.destroy
      render status: :no_content
    else
      render json: { error: "Failed to destroy entry" }, status: :unprocessable_entity
    end
  end

  private

  def handle_exception(e)
    render json: { error: e }, status: :not_found
  end

  def entry_params
    params.permit(:category_id, :content)
  end

  def set_entry
    @entry = Entry.find(params[:id])
  end
end
