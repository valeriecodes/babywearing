# frozen_string_literal: true

class Loan < ApplicationRecord
  # constants
  DEFAULT_CHECKOUT_PERIOD_IN_DAYS =  14

  # relationships
  belongs_to :carrier
  belongs_to :member, class_name: "User"
  belongs_to :checkout_volunteer, class_name: 'User'
  belongs_to :checkin_volunteer, class_name: 'User', optional: true

  # validations
  validates :carrier, :due_date, presence: true

  # callbacks
  before_validation :set_due_date, on: :create

  def set_due_date
    self.due_date = DEFAULT_CHECKOUT_PERIOD_IN_DAYS.days.from_now.utc.to_date if due_date.nil?
  end

  # public instance methods
  def checkin(volunteer)
    self.update(checkin_volunteer: volunteer, returned_at: Time.now.utc)
  end
end
