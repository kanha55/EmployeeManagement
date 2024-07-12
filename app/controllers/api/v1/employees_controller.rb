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
    tax_details = Employee.all.map do |employee|
      EmployeeTaxService.new(employee).tax_details
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
end