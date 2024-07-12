require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :controller do
  let(:valid_attributes) {
    { employee_id: '1234', first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', doj: '2010-01-01', salary: 50000, phone_numbers: ['1234567890'] }
  }

  let(:invalid_attributes) {
    { employee_id: nil, first_name: nil, last_name: nil, email: nil, doj: nil, salary: nil, phone_numbers: [] }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Employee" do
        expect {
          post :create, params: { employee: valid_attributes }
        }.to change(Employee, :count).by(1)
      end

      it "renders a JSON response with the new employee" do
        post :create, params: { employee: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new employee" do
        post :create, params: { employee: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "GET #tax_deductions" do
    it "returns a success response" do
      employee = Employee.create! valid_attributes
      allow(EmployeeTaxService).to receive(:new).and_return(double(tax_details: {}))
      get :tax_deductions, params: {}
      expect(response).to be_successful
    end
  end
end