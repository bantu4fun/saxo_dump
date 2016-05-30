Rails.application.routes.draw do
  match 'home/index', via: [:get, :post]
  root 'home#index'
end
