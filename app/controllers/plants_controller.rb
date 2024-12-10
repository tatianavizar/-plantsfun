class PlantsController < ApplicationController

  def index
    if params[:query].present?
      @plants = Plant.search_by(params[:query]) # Use the `pg_search_scope`
    else
      @plants = Plant.all
    end
  end


  def show
    @plant = Plant.find(params[:id])
  end
end
