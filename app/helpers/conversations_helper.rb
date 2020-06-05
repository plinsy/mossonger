module ConversationsHelper
  def set_conversations
    @conversations = []
    @availables_conversations = current_user.all_availables_conversations
    @pending_conversations = current_user.pending_conversations
  end
end
