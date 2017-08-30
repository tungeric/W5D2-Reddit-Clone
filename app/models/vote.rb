# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  value        :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  validates :value, :user, presence: true
  validates :user, uniqueness: { scope: [:votable] }

  belongs_to :votable, polymorphic: true
  belongs_to :user
end
