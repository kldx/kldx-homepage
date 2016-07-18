class Article < ApplicationRecord
  belongs_to :user
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]

  validates :title, presence: {message: "can't be blank"}, length: { in: 2..250 }
  validates :default_image, presence: {message: "can't be blank"}
  validates :content, presence: {message: "can't be blank"}

  default_scope -> { order('articles.created_at DESC') }

  def should_generate_new_friendly_id?
    title_changed?
  end
end
