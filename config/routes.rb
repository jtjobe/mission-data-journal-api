Rails.application.routes.draw do
  namespace :v1 do
    resources :journals do
      resources :entries
    end
  end
end
