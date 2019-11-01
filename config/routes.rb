Rails.application.routes.draw do
  devise_for :users
  resources :tutors, only: [] do 
    post 'search', on: :collection
  end
  root to: "home#index"
end
