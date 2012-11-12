class Slide < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Accessible Attributes
  attr_accessible :name, :description, :slider_id, :slideable_id, :slideable_type

  # Association
  has_one    :image, as: :attachable
  belongs_to :slider
  belongs_to :slideable, polymorphic: true

  # Validation
  validates :name,      presence: true
  validates :slider_id, presence: true

  def aspect_ratio
    slider.aspect_ratio
  end
end