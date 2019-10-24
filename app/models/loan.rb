# frozen_string_literal: true

class Loan < ApplicationRecord
  DEFAULT_CHECKOUT_PERIOD_IN_DAYS =  14

  belongs_to :carrier

  belongs_to :member, class_name: "User"
  validates :member, presence: true

  belongs_to :checkout_volunteer, class_name: 'User'
  validates :checkout_volunteer, presence: true

  belongs_to :checkin_volunteer, class_name: 'User', optional: true

  validates :carrier, :due_date, presence: true

  before_validation :set_due_date, on: :create

  def set_due_date
    self.due_date = DEFAULT_CHECKOUT_PERIOD_IN_DAYS.days.from_now.utc.to_date if due_date.nil?
  end

  def checkin(volunteer)
    self.update(checkin_volunteer: volunteer, returned_at: Time.now.utc)
  end
end
