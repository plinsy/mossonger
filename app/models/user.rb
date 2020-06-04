class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  
  validates_presence_of :first_name, :last_name, :phone_number
  validates_uniqueness_of :phone_number

  attr_accessor :login
  # relations
  has_one_attached :avatar, dependent: :destroy
  has_many :sent_friendships, class_name: 'Friendship', foreign_key: :sender_id
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :friend_id

  has_one :chat_setting, dependent: :destroy

  has_one :dropbox, foreign_key: :admin_id, dependent: :destroy
  has_many :trashes, through: :dropbox

  has_one :hiding_place, foreign_key: :admin_id, dependent: :destroy
  has_many :secrets, through: :hiding_place

  has_one :space, foreign_key: :admin_id, dependent: :destroy
  has_many :aliens, through: :space

  has_one :blacklist, foreign_key: :admin_id, dependent: :destroy
  has_many :condemneds, through: :blacklist

  has_many :conversations, foreign_key: :admin_id, dependent: :destroy
    has_many :invitations, through: :conversations
    has_many :guests, through: :conversations

  has_many :received_invitations, class_name: "Invitation", foreign_key: :guest_id, dependent: :destroy

  def pending_conversations
    self.received_invitations.map { |i| i.conversation }.select { |c| c.not_available }
  end

  has_many :nicknames, dependent: :destroy

  has_many :messages, foreign_key: :sender_id, dependent: :destroy

  has_many :readings, dependent: :destroy

  after_create_commit :init_user
  def init_user
    # attach a default avatat
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatars', 'default.png')), filename: 'default.png', content_type: 'image/png')

    # make some friends
  	User.all.each_with_index do |u, n|
  		break if n > 50
  		f = Friendship.new(sender: self, friend: u)
  		f.save
  	end

    # init his chat settings
    ChatSetting.create(user: self)

    # create a dropbox for him
    Dropbox.create(admin: self)

    # create a hinding_place
    HidingPlace.create(admin: self)

    # create a space for aliens
    Space.create(admin: self)

    # create a a blacklist for condemned
    Blacklist.create(admin: self)
  end

  def name
    (self.first_name + " " + self.last_name).capitalize
  end

  def was_invited_to?(conversation)
    return conversation.invitations.where(guest: self, is_accepted: true).any?
  end

  def is_a_guest_of?(user)
    return user.guests.include?(self)
  end

  def is_a_host_of?(user)
    return self.guests.include?(user)
  end

  def is_discussing_with?(user)
    return dialog_invitations_with(user).any?
  end

  def dialog_invitations_with(user)
    if self.is_a_guest_of?(user)
      for_a_dialog_invitations = user.invitations.where(guest: self).select { |i| i.is_for_a_dialog? }
    else
      for_a_dialog_invitations = self.invitations.where(guest: user).select { |i| i.is_for_a_dialog? }
    end
    return for_a_dialog_invitations
  end

  def discussion_with(user)
    return dialog_invitations_with(user).first.conversation
  end

  def second_in(conversation)
    conversation.is_a_monolog? ? self : conversation.speakers.select { |g| g.id != self.id }.first
  end

  def friends
    (self.sent_friendships + self.received_friendships).map { |friendship| friendship.friend }
  end

  def nickname_at(conversation)
    conversation.nicknames.where(user: self).first
  end
end