Rails.application.routes.draw do
  get 'resource/:resource', to: 'resource#show'

  root 'dash#index'
end
