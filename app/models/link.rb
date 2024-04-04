class Link < ApplicationRecord
  self.primary_key = :shortcode

  has_many :views, primary_key: :shortcode, foreign_key: :shortcode

  validates :shortcode, presence: true
  validates :url, presence: true, url: { allow_http: true }

  before_validation :set_shortcode

  private

  def set_shortcode
    return if shortcode.present?

    loop do
      self.shortcode = SecureRandom.alphanumeric(4)
      break unless Link.find_by(shortcode:)
    end
  end
end
