Rails.application.routes.draw do
  resources :cities

  root "cities#index"
  get 'details' => 'cities#details'
end
