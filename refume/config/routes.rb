Rails.application.routes.draw do
  root 'static_pages#home'

  #static_pages routes
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/info'

  #user routes
  get 'users/new'
  get 'users/mentor_mentee'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
