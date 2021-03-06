class SOrder < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_one :delivery, dependent: :destroy
  has_one :comment, dependent: :destroy

  scope :filter_by_status, -> (status) { where status: status }
end
