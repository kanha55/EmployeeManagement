require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { build(:employee) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a employee_id" do
    subject.employee_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a doj" do
    subject.doj = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a salary" do
    subject.salary = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a negative salary" do
    subject.salary = -1
    expect(subject).to_not be_valid
  end

  it "is not valid without a phone_numbers" do
    subject.phone_numbers = []
    expect(subject).to_not be_valid
  end
end