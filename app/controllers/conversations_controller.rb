class ConversationsController < ApplicationController
  before_action :set_conversations
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :set_current_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @messages = @conversation.messages.availables.sort { |a, b| a.created_at }
    @react_messages = @conversation.react_messages_for(current_user)
    @message = @conversation.messages.new
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      conversation = Conversation.find(params[:id])
      @conversation = current_user.all_conversations.include?(conversation) ? conversation : nil
      @users = @conversation.users
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:admin_id, :name, :receive_notifications_for_messages, :receive_notifications_for_reactions, :logo)
    end

    def set_conversations
      @conversations = []
      @availables_conversations = current_user.all_availables_conversations
      @pending_conversations = current_user.pending_conversations
    end

    def set_current_conversation
      current_conversation = @conversation
    end
end
