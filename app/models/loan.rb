class Loan < ApplicationRecord
  belongs_to :cart
  belongs_to :carrier

  validates :cart, :carrier, :due_date, presence: true

  validate :due_date_must_be_in_the_future,
    :carrier_must_be_available

  def returned?
    false
  end

  private

  def due_date_must_be_in_the_future
    errors.add(:due_date, "must be in the future") if due_date <= Date.today
  end

  def carrier_must_be_available
    errors.add(:carrier, "must be available") if carrier.checked_out?
  end
end
