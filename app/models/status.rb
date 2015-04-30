class Status < ActiveRecord::Base
  belongs_to :user
  has_one  :location
  has_one  :environment

  accepts_nested_attributes_for :location, :environment

  scope :anonymous, -> { where(anonymous: true) }
  scope :status,    -> { where(status_type: 'status' ) }
  scope :event,     -> { where(status_type: 'event')  }

  validates :description, :user, presence: true
  validates :status_type, inclusion: { in: %w(status event) }

  def self.by_attributes(anonymous = false, type = nil)
    statuses   = where(anonymous: anonymous, status_type: type) if type
    statuses ||= where(anonymous: anonymous)
  end
end
