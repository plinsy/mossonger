module ConversationsHelper
  def set_conversations
    @conversations = []
    @filter = params[:filter]
    @availables_conversations = current_user.all_availables_conversations
    if @filter
    	case @filter
    	when 'unread'
    		@availables_conversations = @availables_conversations.select { |c| current_user.unread_conversation?(c) }
    	end
    end
    @pending_conversations = current_user.pending_conversations
  end
end
