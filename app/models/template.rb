class Template < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Attributes
  attr_accessible :body, :description, :name

  # Validations
  validates :name, presence: true
end