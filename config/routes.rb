Rails.application.routes.draw do
  namespace :v1 do
    resources :journals
  end
end
