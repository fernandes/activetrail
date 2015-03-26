Rails.application.routes.draw do
  resources :book
  ActiveAdmin.routes(self)
  #
end
