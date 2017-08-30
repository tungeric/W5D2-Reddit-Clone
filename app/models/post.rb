# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  include Votable
  validates :title, :author, presence: true
  validates :subs, presence: { message: 'must have at least one sub' }

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments

  def comments_by_parent
    comments_by_parent = Hash.new { |h, k| h[k]=[] }
    self.comments.each do |comment|
      comments_by_parent[comment.parent_comment] << comment
    end
    comments_by_parent
  end
end
