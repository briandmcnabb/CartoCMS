class Slide < ActiveRecord::Base
  #extend FriendlyId
  #friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Accessible Attributes
  attr_accessible :name, :description, :slider_id, :slideable_id, :slideable_type

  # Association
  has_one    :image
  belongs_to :slider
  belongs_to :slideable, polymorphic: true

  # Validation
  validates :position,  presence: true
  validates :name,      presence: true
  validates :slider_id, presence: true
end