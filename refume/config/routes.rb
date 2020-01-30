Rails.application.routes.draw do
  root 'static_pages#home'
  get 'users/new'

  get 'static_pages/home'

  get 'static_pages/about'

  get 'users/mentor_mentee'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
