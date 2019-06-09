Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'v2', constraints: ApiVersion.new('v2') do
    resources :teams do
      resources :players
    end
  end

  scope module: 'v1', constraints: ApiVersion.new('v1', true) do
    resources :teams do
      resources :players
    end
  end
end
