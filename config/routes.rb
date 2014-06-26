Rails.application.routes.draw do
  get   '/trgovina',  to: 'trgovina#index'
  get   '/start',     to: 'start#index'
  get   '/home',      to: 'home#index'

  root  'start#index'
end
