class Message < ApplicationRecord
	scope :availables, -> { select { |msg| msg.persisted? && !msg.dropped? } }
  belongs_to :sender, class_name: "User"
  belongs_to :conversation
  has_many_attached :files, dependent: :destroy
  has_many :readings, dependent: :destroy
    has_many :readers, class_name: "User", through: :readings, source: :user

  has_many :trashes, as: :trashable

  validates_presence_of :content

  def shared_by(user)
    user.read(self)
    data = {
      id: self.id,
      c_id: self.conversation.id,
      c_view: render_conversation(self.conversation, self),
      content: self.content,
      sender_id: self.sender.id,
      sender: self.sender.name,
      avatar: url_for(user.avatar),
      position: self.position_for(user),
      direction: self.direction_for(user),
      color: self.color_for(user),
      created_at: I18n.l(self.created_at, format: :long),
      message_sender_view: render_sender_message(self),
      message_guests_view: render_guests_message(self)
    }
    ActionCable.server.broadcast 'conversation_channel', data
  end

  def is_from?(user)
  	return self.sender == user
  end

  def position_for(user)
    self.is_from?(user) ? 'flex-row-reverse' : ''
  end

  def direction_for(user)
  	self.is_from?(user) ? 'right' : 'left'
  end

  def oposite_direction_for(user)
    self.is_from?(user) ? 'left' : 'right'
  end

  def hide_for(user)
  	self.is_from?(user) ? 'd-none' : ''
  end

  def color_for(user)
  	self.is_from?(user) ? 'info' : 'light'
  end

  def read_from(user)
    user.read?(self) ? 'read' : 'unread'
  end

  def readers_names
    self.readers.map { |r| r.name }
  end

  def seen_by
    "Seen by " + self.readers_names.join(', ')
  end

  def nickname
    self.sender.nickname_at(self.conversation)
  end
  
  private
  def render_sender_message(message)
    MessagesController.render(
      partial: 'messages/message',
      locals: {current_user: message.sender, message: message}
    )
  end
  def render_guests_message(message)
    MessagesController.render(
      partial: 'messages/guests_message',
      locals: {current_user: message.sender, message: message}
    )
  end
  def render_conversation(conversation, message)
    ConversationsController.render(
      partial: "conversations/conversation",
      locals: {current_user: message.sender, conversation: conversation, show_options: true}
    )
  end
end
