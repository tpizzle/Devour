# == Schema Information
#
# Table name: user_votes
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  user_id      :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe UserVote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
