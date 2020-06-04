class ChatSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_setting, only: [:show, :edit, :update, :destroy]

  # GET /chat_settings
  # GET /chat_settings.json
  def index
    @chat_settings = ChatSetting.all
  end

  # GET /chat_settings/1
  # GET /chat_settings/1.json
  def show
  end

  # GET /chat_settings/new
  def new
    @chat_setting = ChatSetting.new
  end

  # GET /chat_settings/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /chat_settings
  # POST /chat_settings.json
  def create
    @chat_setting = ChatSetting.new(chat_setting_params)

    respond_to do |format|
      if @chat_setting.save
        format.html { redirect_to @chat_setting, notice: 'Chat setting was successfully created.' }
        format.json { render :show, status: :created, location: @chat_setting }
      else
        format.html { render :new }
        format.json { render json: @chat_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chat_settings/1
  # PATCH/PUT /chat_settings/1.json
  def update
    respond_to do |format|
      if @chat_setting.update(chat_setting_params)
        format.html { redirect_to @chat_setting, notice: 'Chat setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat_setting }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @chat_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_settings/1
  # DELETE /chat_settings/1.json
  def destroy
    @chat_setting.destroy
    respond_to do |format|
      format.html { redirect_to chat_settings_url, notice: 'Chat setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_setting
      @chat_setting = current_user.chat_setting
    end

    # Only allow a list of trusted parameters through.
    def chat_setting_params
      params.require(:chat_setting).permit(:user_id, :active_status, :enable_sounds, :enable_notifications)
    end
end
