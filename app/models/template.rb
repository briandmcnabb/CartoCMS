class Template < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Validations
  validates :name,    presence: true
end