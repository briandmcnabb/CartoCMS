class PageTemplate < ActiveRecord::Base
  acts_as_list

  # Validations
  validates :position, presence: true
  validates :title,    presence: true
  validates :body,     presence: true
end