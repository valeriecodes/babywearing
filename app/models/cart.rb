class Cart < ApplicationRecord
  belongs_to :member, class_name: "User"
  validates :member, presence: true

  belongs_to :volunteer, class_name: "User"
  validates :volunteer, presence: true

  has_many :loans
  validates_associated :loans

  validate :there_must_be_line_items,
    :member_must_be_able_to_check_out_this_many_carriers

  def line_items
    loans
  end

  def checkout
  end

  private

  def there_must_be_line_items
    errors.add(:line_items, "can't be empty")
  end

  def member_must_be_able_to_check_out_this_many_carriers
    errors.add(:loans, "must be <= 2") unless loans.size <= 2
  end
end
