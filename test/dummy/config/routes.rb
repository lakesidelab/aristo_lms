Rails.application.routes.draw do

  get 'welcome/index'

  post '/login', to: 'sessions#create', as: 'login'

  delete '/logout', to: 'sessions#delete', as: 'logout'

  root 'welcome#index'

  mount AristoLms::Engine => "/aristo_lms"
end
