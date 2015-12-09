Rails.application.routes.draw do
  get 'resource/:resource/:start/:stop', to: 'resource#show'
  get 'resource/:resource', to: 'resource#show', :defaults => { :start => 7.days.ago.to_s, :stop => DateTime.now.to_s }, as: :resource

  root 'dash#index'
end
