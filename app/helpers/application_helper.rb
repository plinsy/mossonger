module ApplicationHelper
  def page_not_free?
    return %(pages).exclude?(controller_name)
  end
  
  def current_conversation=(conversation)
    cookies.push({:c_id => conversation.id})
    session.push({:c_id => conversation.id})
    puts "CCI"*23
    puts cookies[:c_id]
    puts session[:c_id]
    en
  end

  def current_conversation
    puts "CC"*23
    puts cookies[:c_id]
    puts session[:c_id]
    current_user.conversations.find(cookies[:c_id])
  end

  def not_created
    render template: 'shared/not_created'
  end

  def authenticity_token
    session[:_csrf_token] ||= SecureRandom.base64(32)
  end

  def not_found(q)
    render partial: 'shared/not_found', locals: {q: q}
  end
end
