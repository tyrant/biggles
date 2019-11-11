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

  resources :tutors, only: [] do 
    post 'search', on: :collection
  end
  
  root to: "home#index"
end
