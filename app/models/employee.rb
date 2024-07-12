class Employee < ApplicationRecord
  serialize :phone_numbers, Array

  validates :employee_id, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, :doj, :salary, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :salary, numericality: { greater_than_or_equal_to: 0 }

  validate :validate_phone_numbers

  private

  def validate_phone_numbers
    if phone_numbers.blank? || !phone_numbers.is_a?(Array) || phone_numbers.any?(&:blank?)
      errors.add(:phone_numbers, "must contain at least one valid phone number")
    end
  end
end
