Rails.application.routes.draw do
  devise_for :users,
             only: [:sessions, :passwords],
             controllers: {
                 sessions:      'sessions',
             }
  resources :statuses, except: [:new, :show]
  resource  :users, except: [:new, :edit]
end
