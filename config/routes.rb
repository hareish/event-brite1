Rails.application.routes.draw do
  devise_for :users
  
   root 'events#index'
  
   resources :users

   resources :attendances
   
   resources :events

   resources :events do
    resources :charges
   end 
   

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

