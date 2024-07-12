Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :employees, only: [:create] do
        collection do
          get :tax_deductions
        end
      end
    end
  end
end
