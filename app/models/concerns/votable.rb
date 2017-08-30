module Votable
  extend ActiveSupport::Concern

  # code in this block will be run in class scope when the concern is included
  included do
    has_many :votes, as: :votable
  end

  def sum_votes
    self.votes.sum(:value)
  end
end
