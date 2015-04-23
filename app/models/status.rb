class Status < ActiveRecord::Base
  belongs_to :user
  has_one  :location
  has_one  :environment

  accepts_nested_attributes_for :location, :environment

  validates :title, :description, :user, presence: true
  validates :status_type, inclusion: { in: %w(status event) }
end
