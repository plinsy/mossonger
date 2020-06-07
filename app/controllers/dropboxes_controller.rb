class DropboxesController < ApplicationController
  before_action :set_dropbox, only: [:show, :edit, :update, :destroy, :drop]
  before_action :set_dropable, only: [:drop]

  # GET /dropboxes
  # GET /dropboxes.json
  def index
  end

  # GET /dropboxes/1
  # GET /dropboxes/1.json
  def show
    @dropbox = current_user.dropbox
    @trashes = @dropbox.trashes
    @conversations_trashes = @trashes.where(trashable_type: "Conversation")
    @dropped_conversations = @conversations_trashes.map { |t| t.trashable }
    respond_to do |format|
      format.js
    end
  end

  # GET /dropboxes/new
  def new
    @dropbox = Dropbox.new
  end

  # GET /dropboxes/1/edit
  def edit
  end

  # POST /dropboxes
  # POST /dropboxes.json
  def create
    @dropbox = Dropbox.new(dropbox_params)

    respond_to do |format|
      if @dropbox.save
        format.html { redirect_to @dropbox, notice: 'Dropbox was successfully created.' }
        format.json { render :show, status: :created, location: @dropbox }
      else
        format.html { render :new }
        format.json { render json: @dropbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dropboxes/1
  # PATCH/PUT /dropboxes/1.json
  def update
    respond_to do |format|
      if @dropbox.update(dropbox_params)
        format.html { redirect_to @dropbox, notice: 'Dropbox was successfully updated.' }
        format.json { render :show, status: :ok, location: @dropbox }
      else
        format.html { render :edit }
        format.json { render json: @dropbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dropboxes/1
  # DELETE /dropboxes/1.json
  def destroy
    @dropbox.destroy
    respond_to do |format|
      format.html { redirect_to dropboxes_url, notice: 'Dropbox was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def drop
    @item = @dropbox.drop(@dropable)
    respond_to do |format|
      if @item
        format.js {
          render :dropped
        }
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
    def set_dropbox
      @dropbox = current_user.dropbox
    end

    # Only allow a list of trusted parameters through.
    def dropbox_params
      params.require(:dropbox).permit(:admin_id)
    end

    def set_dropable
      @dropable_type = params[:dropable_type]
      @dropable_id = params[:dropable_id]
      case @dropable_type
      when 'message'
        @dropable = Message.find(@dropable_id)
      when 'conversation'
        @dropable = Conversation.find(@dropable_id)
      end
    end
end