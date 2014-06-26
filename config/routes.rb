Rails.application.routes.draw do

  get   '/news/:id',  to: 'vijesti#show'
  get   '/news',      to: 'vijesti#index'
  get   '/trgovina',  to: 'trgovina#index'
  get   '/start',     to: 'start#index'
  get   '/home',      to: 'home#index'

  root  'start#index'
end
