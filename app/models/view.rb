class View < ApplicationRecord
  belongs_to :link, primary_key: :shortcode, foreign_key: :shortcode

  validates :shortcode, presence: true
end
