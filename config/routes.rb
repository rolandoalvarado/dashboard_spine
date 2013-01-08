DashboardSpine::Application.routes.draw do
  resources :projects
  root :to => 'site#index'
end
