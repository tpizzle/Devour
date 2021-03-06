# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  password_digest        :string           not null
#  session_token          :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_digest  :string
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
  validate :password_confirmed
  before_save :valid_email
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many(
    :owned_decks,
    class_name: 'Deck',
    foreign_key: :owner_id,
    primary_key: :id
  )
  has_many :deck_shares
  has_many :decks, through: :deck_shares
  has_many :cards, through: :decks
  has_many :responses
  has_many(
    :sent_messages,
    class_name: 'Message',
    foreign_key: :sender_id,
    primary_key: :id
  )
  has_many(
    :received_messages,
    class_name: 'Message',
    foreign_key: :receiver_id,
    primary_key: :id
  )

  attr_accessor :password, :password_confirmation,
                :password_reset_token, :score

  def password_confirmed
    if (password != password_confirmation)
      self.errors[:password] = "Passwords did not match!"
    end
  end

  def valid_email
    /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/ =~ self.email.upcase
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def create_reset_digest
    self.password_reset_token = SecureRandom::urlsafe_base64(24)
    self.password_reset_digest = BCrypt::Password.create(self.password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save!
  end

  def self.find_by_credentials(params)
    user = User.find_by(email: params[:email].downcase)
    if user && user.is_password?(params[:password])
      return user
    else
      return nil
    end
  end

  def review_cards
    return cards.select { |card| card.needs_review?(self.id) }
  end

  def latest_response
    return responses.order('created_at DESC').first if responses.length != 0
  end

  def data
    review_times = []
    one_day = 60 * 60 * 24*1000
    self.cards.each do |card|
      lapsed_time = (Time.now.to_f * 1000 - card.latest_response(self.id).last_passed)/one_day
      review_times.push(lapsed_time.round)
    end
    review_times
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
