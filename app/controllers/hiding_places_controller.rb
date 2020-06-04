class HidingPlacesController < ApplicationController
  before_action :set_hiding_place, only: [:show, :edit, :update, :destroy]

  # GET /hiding_places
  # GET /hiding_places.json
  def index
    @hiding_places = HidingPlace.all
  end

  # GET /hiding_places/1
  # GET /hiding_places/1.json
  def show
  end

  # GET /hiding_places/new
  def new
    @hiding_place = HidingPlace.new
  end

  # GET /hiding_places/1/edit
  def edit
  end

  # POST /hiding_places
  # POST /hiding_places.json
  def create
    @hiding_place = HidingPlace.new(hiding_place_params)

    respond_to do |format|
      if @hiding_place.save
        format.html { redirect_to @hiding_place, notice: 'Hiding place was successfully created.' }
        format.json { render :show, status: :created, location: @hiding_place }
      else
        format.html { render :new }
        format.json { render json: @hiding_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hiding_places/1
  # PATCH/PUT /hiding_places/1.json
  def update
    respond_to do |format|
      if @hiding_place.update(hiding_place_params)
        format.html { redirect_to @hiding_place, notice: 'Hiding place was successfully updated.' }
        format.json { render :show, status: :ok, location: @hiding_place }
      else
        format.html { render :edit }
        format.json { render json: @hiding_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hiding_places/1
  # DELETE /hiding_places/1.json
  def destroy
    @hiding_place.destroy
    respond_to do |format|
      format.html { redirect_to hiding_places_url, notice: 'Hiding place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hiding_place
      @hiding_place = HidingPlace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hiding_place_params
      params.require(:hiding_place).permit(:admin_id)
    end
end
