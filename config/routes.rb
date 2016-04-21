Rails.application.routes.draw do
  get 'programs', to: 'program#index'

  get 'programs/:program', to: 'program#show'

  get 'resource/electricity/:start/:stop', to: 'resource#electricity'
  get 'resource/water/:start/:stop', to: 'resource#water'
  get 'resource/electricity', to: 'resource#electricity', :defaults => { :start => 7.days.ago.to_s, :stop => DateTime.now.to_s }, as: 'electricity'
  get 'resource/water', to: 'resource#water', :defaults => { :start => 7.days.ago.to_s, :stop => DateTime.now.to_s }, as: 'water'
  
  root 'dash#index'
end
