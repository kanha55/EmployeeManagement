class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def tax_deductions
    employees = Employee.all
    tax_details = employees.map do |employee|
      monthly_salary = employee.salary
      months_worked = calculate_months_worked(employee.doj)
      total_salary = monthly_salary * months_worked
      tax_amount = calculate_tax(total_salary)
      cess_amount = calculate_cess(total_salary)

      {
        employee_code: employee.employee_id,
        first_name: employee.first_name,
        last_name: employee.last_name,
        yearly_salary: total_salary,
        tax_amount: tax_amount,
        cess_amount: cess_amount
      }
    end
    render json: tax_details, status: :ok
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:employee_id, :first_name, :last_name, :email, :doj, :salary, phone_numbers: [])
  end

  def calculate_months_worked(doj)
    doj = doj.to_date
    end_date = Date.today.end_of_financial_year
    months = (end_date.year * 12 + end_date.month) - (doj.year * 12 + doj.month)
    days_in_start_month = Date.civil(doj.year, doj.month, -1).day - doj.day + 1
    months -= 1 if days_in_start_month < 30
    months
  end

  def calculate_tax(yearly_salary)
    tax = 0
    if yearly_salary > 250000
      tax += [yearly_salary - 250000, 250000].min * 0.05
    end
    if yearly_salary > 500000
      tax += [yearly_salary - 500000, 500000].min * 0.10
    end
    if yearly_salary > 1000000
      tax += (yearly_salary - 1000000) * 0.20
    end
    tax
  end

  def calculate_cess(yearly_salary)
    yearly_salary > 2500000 ? (yearly_salary - 2500000) * 0.02 : 0
  end
end

class Date
  def end_of_financial_year
    year_start = Date.new(self.month >= 4 ? self.year : self.year - 1, 4, 1)
    year_start.next_year - 1
  end
end
