class Conversation < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_one_attached :logo
  has_many :invitations, dependent: :destroy
  has_many :guests, through: :invitations
  has_many :nicknames, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :aliens, as: :muteable, dependent: :destroy
    has_many :spaces, through: :aliens

  after_create_commit :init_self
  before_validation :add_default_name

  def init_self
    self.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'logos', 'default-room.png')), filename: 'default-room.png', content_type: 'image/png')  
    self.nicknames.create(user: self.admin)
  end

  def add_default_name
  	if self.name.nil?
  		self.name = "Conversation with #{self.admin.name}"
  	end
  end

  def is_a_dialog?
  	return self.max_users == 1
  end

  def is_ready?
    if self.is_a_dialog?
      return self.invitations.first.is_accepted
    else
      return true
    end
  end

  def last_writter
    self.messages.last.sender
  end

  def self.ready
    select { |c| c.is_ready? }
  end

  def users
    return (self.guests + [self.admin])
  end

  def react_messages_for(user)
    messages = []
    self.messages.each do |msg|
      messages.push({
        id: msg.id,
        content: msg.content,
        sender: msg.sender.name,
        avatar: url_for(msg.sender.avatar),
        position: msg.position_for(user),
        direction: msg.direction_for(user),
        color: msg.color_for(user),
        created_at: I18n.l(self.created_at, format: :long)
      })
    end
    messages
  end

  def speakers
    s = self.guests
    return s + [self.admin]
  end

  def speakers_names
    names = speakers.map { |s| s.name }
    return names.join(', ').downcase
  end

  def is_a_monolog?
    self.is_a_dialog? && self.guests == [self.admin]
  end

  def is_in_group?
    self.max_users > 1
  end

  def self.availables
    select { |c| c.is_a_monolog? || (c.is_a_dialog? && c.invitations.first.is_accepted) || c.is_in_group? }
  end

  def not_available
    self.invitations.each do |invitation|
      return true if invitation.is_not_accepted
    end
    return false
  end

  def self.search(q, user)
    q.downcase!
    contacts = select { |c| c.is_a_dialog? && c.speakers.include?(user) && (c.name.include?(q) || c.speakers_names.include?(q)) }
    groups = select { |c| c.is_in_group? && c.speakers.include?(user) && (c.name.include?(q) || c.speakers_names.include?(q)) }
    more = select { |c| c.name.include?(q) || c.speakers_names.include?(q) }
    result = [contacts, groups, more]
  end

  def muted_for?(user)
    user.aliens.where(muteable: self).any?
  end

  def alien_from(user)
    self.aliens.where(space: user.space)
  end

  def read_from(user)
    user.read_conversation?(self) ? 'read' : 'unread'
  end
end
