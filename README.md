# Employee Management API

This is a Ruby on Rails application that provides REST APIs to manage employee details and calculate tax deductions.

## Features

1. Store employee details with validation.
2. Calculate and return employees' tax deductions for the current financial year.

## Requirements

- Ruby 3.0.0
- Rails 7.0.8.4
- PostgreSQL (or any other preferred database)

## Setup

1. Clone the repository:

   ```sh
   git clone https://github.com/kanha55/EmployeeManagement.git
   cd EmployeeManagement

2. Install dependencies:

    bundle install

3. Set up the database:

    rails db:create
    rails db:migrate

4. Start the Rails server:

    rails server

API Endpoints
Create Employee

Endpoint: POST /api/v1/employees

Request: 
{
  "employee": {
    "employee_id": "E12345",
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe@example.com",
    "phone_numbers": ["1234567890"],
    "doj": "2023-05-16",
    "salary": 50000
  }
}

Tax Deductions

Endpoint: GET /api/v1/employees/tax_deductions


