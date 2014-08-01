Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get   '/press',       to: 'press#index'
  get   '/documents',   to: 'documents#index'
  get   '/news/:id',    to: 'vijesti#show'
  get   '/news',        to: 'vijesti#index'
  get   '/trafficking', to: 'trgovina#index'
  get   '/start',       to: 'start#index'
  get   '/home',        to: 'home#index'
  get   '/about',       to: 'about#index'
  get   '/compensation',to: 'compensation#index'

  root  'start#index'
end
