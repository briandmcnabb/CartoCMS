class PageTemplate < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Validations
  validates :position, presence: true
  validates :name,    presence: true
  validates :body,     presence: true
end