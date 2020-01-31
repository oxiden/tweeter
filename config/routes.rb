Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'menus#index'

  resources :shops, :only => [:index, :show] do
    resources :menus, :only => [:index, :show]
  end
end
