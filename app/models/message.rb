class Message < ApplicationRecord
  scope :availables, -> { select { |msg| msg.persisted? && !msg.dropped? } }
  belongs_to :sender, class_name: "User"
  belongs_to :conversation
  belongs_to :messageable, polymorphic: true, optional: true
  has_many :messages, as: :messageable
  has_many_attached :files, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :readers, class_name: "User", through: :readings, source: :user

  has_many :trashes, as: :trashable
  has_many :dropboxes, through: :trashes
  has_many :droppers, class_name: "User", through: :dropboxes, source: :admin

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
      message_sender_view: render_message(self, self.sender),
      message_guests_view: render_message(self, self.conversation.users.select { |u| u != self.sender})
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

  def siblings
    self.conversation.messages
  end

  def previous
    p_id = self.siblings.index(self) - 1
    p_id >= 0 ? self.siblings[p_id] : false
  end

  def next
    n_id = self.siblings.index(self) + 1
    n_id >= 0 ? self.siblings[n_id] : false
  end

  def from?(user)
    self.sender == user
  end

  def date_changed?
    self.previous && self.previous.created_at.day != self.created_at.day
  end

  def borders_for(user)
    if user == self.sender
      if self.previous && self.previous.from?(self.sender) && self.next && self.next.from?(self.sender)
        b = "no-br-"+self.direction_for(user)
      elsif self.previous && self.previous.from?(self.sender)
        b = "no-br-top"
      elsif self.next && self.next.from?(self.sender)
        b = "no-br-bottom"
      end
    end
    b
  end

  private
  def render_message(message, current_user)
    MessagesController.render(
      partial: "messages/message",
      locals: {current_user: current_user, message: message}
    )
  end
  def render_conversation(conversation, message)
    ConversationsController.render(
      partial: "conversations/conversation",
      locals: {current_user: message.sender, conversation: conversation, show_options: true}
    )
  end
end
