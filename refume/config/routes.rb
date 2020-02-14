Rails.application.routes.draw do
  get 'sessions/new'

  resources :matches
  root 'static_pages#home'
  get  '/home',          to: 'static_pages#home'
  get  '/help',          to: 'static_pages#help'
  get  '/about',         to: 'static_pages#about'
  get  '/info',          to: 'static_pages#info'
  get  '/contact',       to: 'static_pages#contact'
  get  '/signup',        to: 'users#new'
  get  '/mentor_mentee', to: 'users#mentor_mentee'
  get    '/login',       to: 'sessions#new'
  post   '/login',       to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
