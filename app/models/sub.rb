class Sub < ActiveRecord::Base
  validates :title, :moderator_id, presence: true
  validates_uniqueness_of :title, scope: :moderator_id

  has_many :post_subs, inverse_of: :sub
  has_many :posts, through: :post_subs, source: :post

  belongs_to(
  :moderator,
  class_name: 'User',
  primary_key: :id,
  foreign_key: :moderator_id
  )


end
