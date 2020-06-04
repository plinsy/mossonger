class Message < ApplicationRecord
	scope :availables, -> { select { |msg| msg.persisted? } }
  belongs_to :sender, class_name: "User"
  belongs_to :conversation
  has_many_attached :files, dependent: :destroy
  has_many :readings, dependent: :destroy

  validates_presence_of :content

  def shared_by(user)
    data = {
      id: self.id,
      content: self.content,
      sender: self.sender.name,
      avatar: url_for(user.avatar),
      position: self.position_for(user),
      direction: self.direction_for(user),
      color: self.color_for(user),
      created_at: I18n.l(self.created_at, format: :long),
      message_view: render_message(self)
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

  def hide_for(user)
  	self.is_from?(user) ? 'd-none' : ''
  end

  def color_for(user)
  	self.is_from?(user) ? 'info' : 'light'
  end

  private
  def render_message(message)
    MessagesController.render(
      partial: 'messages/message',
      locals: {current_user: message.sender, message: message}
    )
  end
end
