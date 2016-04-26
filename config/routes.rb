Rails.application.routes.draw do
  get 'info', to: 'info#show', :defaults => { :page => 0 }, as: 'info'
  get 'info/:page', to: 'info#show'

  get 'programs', to: 'program#index'

  get 'programs/:program', to: 'program#show'

  get 'resource/electricity/:start/:stop', to: 'resource#electricity'
  get 'resource/water/:start/:stop', to: 'resource#water'
  get 'resource/electricity', to: 'resource#electricity', :defaults => { :start => 7.days.ago.to_date.to_s, :stop => Date.today.to_s }, as: 'electricity'
  get 'resource/water', to: 'resource#water', :defaults => { :start => 7.days.ago.to_date.to_s, :stop => Date.today.to_s }, as: 'water'
  
  root 'dash#index'
end
