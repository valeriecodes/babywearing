class Carrier < ApplicationRecord
  belongs_to :location
  belongs_to :category

  has_many :loans

  validates :item_id, uniqueness: { message: 'Item ID has already been taken' }
  validates :name,
    :item_id,
    :location_id,
    :default_loan_length_days,
    :category_id,
    :status,
    presence: true

  has_many_attached :photos

  def build_loan(attributes = {})
    loans.create({
      due_date: Date.today + default_loan_length_days.days,
    }.merge(attributes))
  end

  def checked_out?
    most_recent_loan.returned?
  end

  def most_recent_loan
    loans.order(created_at: :desc).first
  end
end
