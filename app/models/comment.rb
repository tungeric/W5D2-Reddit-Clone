# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  content           :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ApplicationRecord
  validates :author, :post, :content, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  belongs_to :post

  has_many :child_comments,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    primary_key: :id

  belongs_to :parent_comment,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    primary_key: :id,
    optional: true


end
