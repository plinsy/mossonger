class CondemnedsController < ApplicationController
  before_action :set_condemned, only: [:show, :edit, :update, :destroy]

  # GET /condemneds
  # GET /condemneds.json
  def index
    @condemneds = Condemned.all
  end

  # GET /condemneds/1
  # GET /condemneds/1.json
  def show
  end

  # GET /condemneds/new
  def new
    @condemned = Condemned.new
  end

  # GET /condemneds/1/edit
  def edit
  end

  # POST /condemneds
  # POST /condemneds.json
  def create
    @condemned = Condemned.new(condemned_params)

    respond_to do |format|
      if @condemned.save
        format.html { redirect_to @condemned, notice: 'Condemned was successfully created.' }
        format.json { render :show, status: :created, location: @condemned }
      else
        format.html { render :new }
        format.json { render json: @condemned.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condemneds/1
  # PATCH/PUT /condemneds/1.json
  def update
    respond_to do |format|
      if @condemned.update(condemned_params)
        format.html { redirect_to @condemned, notice: 'Condemned was successfully updated.' }
        format.json { render :show, status: :ok, location: @condemned }
      else
        format.html { render :edit }
        format.json { render json: @condemned.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condemneds/1
  # DELETE /condemneds/1.json
  def destroy
    @condemned.destroy
    respond_to do |format|
      format.html { redirect_to condemneds_url, notice: 'Condemned was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condemned
      @condemned = Condemned.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def condemned_params
      params.require(:condemned).permit(:blacklist_id, :blockable_id)
    end
end
