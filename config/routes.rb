Rails.application.routes.draw do
  get 'resource/:resource', to: 'resource#show', as: :resource

  root 'dash#index'
end
