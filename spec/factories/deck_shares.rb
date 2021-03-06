# == Schema Information
#
# Table name: deck_shares
#
#  id         :integer          not null, primary key
#  deck_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :deck_share do
    deck_id 1
    user_id 1
    association :user, factory: :user
    association :deck, factory: :deck
  end

end
