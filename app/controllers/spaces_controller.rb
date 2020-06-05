class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy, :mute]
  before_action :set_muteable, only: %i(mute)

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)

    respond_to do |format|
      if @space.save
        format.html { redirect_to @space, notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to @space, notice: 'Space was successfully updated.' }
        format.json { render :show, status: :ok, location: @space }
      else
        format.html { render :edit }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mute
    respond_to do |format|
      if @space.mute(@muteable)
        format.js
      else
        format.js {
          flash[:error] = "Not archived"
          not_created
        }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = current_user.space
    end

    # Only allow a list of trusted parameters through.
    def space_params
      params.require(:space).permit(:admin_id)
    end

    def set_muteable
      @muteable_type = params[:muteable_type]
      @muteable_id = params[:muteable_id]
      case @muteable_type
      when 'conversation'
        @muteable = Conversation.find(@muteable_id)
      end
    end
end
