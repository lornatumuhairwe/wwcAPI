Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams do
    resources :players
  end

  post '/get_api_key', to: 'users#generate_api_key'
end
