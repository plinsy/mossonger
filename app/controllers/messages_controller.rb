class MessagesController < ApplicationController
  include ConversationsHelper
  before_action :set_conversations
  before_action :set_conversation, except: [:new]
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  layout 'messages'
  # GET /messages
  # GET /messages.json
  def index
    @messages = @conversation.messages.select { |m| m.persisted? }.sort { |a, b| a.created_at }
    @msgs_pagy, @msgs = pagy_array(@messages, items: 25, page_param: :msgs_page, msgs_page: params[:msgs_page])
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = current_user.messages.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user

    if @message.save
      @message.shared_by(current_user)
      head :ok
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.js { 
          flash[:danger] = @message.errors.full_messages.join(', ')
          render :new 
        }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @conversation, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @id = @message.id
    @message.destroy
    respond_to do |format|
      format.html { redirect_to @conversation, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def reply
    @messageable_type = params[:messageable_type]
    @messageable_id = params[:messageable_id]
    @messageable = instance_eval "#{@messageable_type.camelize}.find(#{@messageable_id})"
    @message = current_user.messages.new(
      conversation: @messageable.conversation, 
      messageable: @messageable
    )
    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = @conversation.messages.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content, :messageable_type, :messageable_id)
  end

  def set_conversation
    conversation = Conversation.find(params[:conversation_id])
    @conversation = current_user.all_conversations.include?(conversation) ? conversation : nil
  end
end
