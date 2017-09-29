Rails.application.routes.draw do
  get 'info', to: 'info#show', defaults: { page: 0 }, as: 'info'
  get 'info/:page', to: 'info#show'

  get 'programs', to: 'program#index'

  get 'programs/:program', to: 'program#show'

  default_chart = { chart: 'subtype'}
  default_w_dates = { start: 7.days.ago.to_date.to_s, stop: Date.today.to_s }.merge!(default_chart)
  get '/resource/electricity/:chart/:start/:stop', to: 'resource#electricity'
  get '/resource/water/:chart/:start/:stop', to: 'resource#water'
  get 'resource/electricity/:start/:stop', to: 'resource#electricity', defaults: default_chart
  get 'resource/water/:start/:stop', to: 'resource#water', defaults: default_chart
  get 'resource/electricity', to: 'resource#electricity', defaults: default_w_dates, as: 'electricity'
  get 'resource/water', to: 'resource#water', defaults: default_w_dates, as: 'water'
  
  root 'dash#index'
end
