class ConversationsController < ApplicationController
  include ConversationsHelper
  
  before_action :set_conversations
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :set_current_conversation, only: [:show, :edit, :update, :destroy]  

  # GET /conversations.json
  def index
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @messages = @conversation.messages.select { |m| m.persisted? }.sort { |a, b| a.created_at }
    @paged_msgs = Kaminari.paginate_array(@messages).page(params[:msg_page]).per(25)
    @msgs_pagy, @msgs = pagy_array(@messages, items: 25, page_param: :msgs_page)
    @react_messages = @conversation.react_messages_for(current_user)
    @message = @conversation.messages.new
    current_user.read_conversation(@conversation)
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

  def search
    @q = params[:conversations][:q]
    @target = params[:conversations][:target]
    @result = Conversation.search(@q, current_user) # @result => [contacts, groups, more]
    @contacts = @result[0]
    @groups = @result[1]
    @more = @result[2]
    respond_to do |format|
      format.js
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

    def set_current_conversation
      current_conversation = @conversation
    end
end
