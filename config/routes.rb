Rails.application.routes.draw do

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             },
             defaults: {
               format: :json
             }
  devise_scope :user do
    get 'users/current', to: 'sessions#show'
  end


  resources :tutors, only: [:update] do 
    post 'search', on: :collection
  end
  
  root to: "home#index"
end
