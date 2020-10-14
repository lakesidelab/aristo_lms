AristoLms::Engine.routes.draw do


  get '/start/:training_id', to: 'trainings#start_module', as: 'start_training'

  post '/answer', to: 'subscriptions#quiz', as:'submit_answer'

  post '/finish', to: 'subscriptions#finish', as: 'finish_track'

  resources :subscriptions


  scope '/studio' do
    resources :trainings do
      collection do
        patch :sort
      end
    end
  end




end