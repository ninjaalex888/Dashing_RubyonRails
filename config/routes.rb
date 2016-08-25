DashingRailsDemo::Application.routes.draw do
  mount Dashing::Engine, at: Dashing.config.engine_path

  	root :to => 'dashboard#list'

	get 'widget/list'
	get 'widget/new'
	post 'widget/create'
	patch 'widget/update'
	get 'widget/list'
	get 'widget/show'
	get 'widget/edit'
	get 'widget/delete'
	get 'widget/update'
	get 'dashboard/list'
	get 'dashboard/new'
	post 'dashboard/create'
	patch 'dashboard/update'
	get 'dashboard/list'
	get 'dashboard/show'
	get 'dashboard/edit'
	get 'dashboard/delete'
	get 'dashboard/update'

	get '/authorization' => 'sessions#authorization'
	get '/sign_in' => 'sessions#new'
	get '/sign_out' => 'sessions#destroy'
	get '/auth/github/callback' =>'sessions#create'


    get 'users/:id' => 'users#show'
    get '/users' => 'users#lists'
	
  end
