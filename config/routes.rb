Rails.application.routes.draw do

	ActiveAdmin.routes(self)

	root to: 'rooms#index'

	get 'login' => 'sessions#new', as: :login
	post 'login' => 'sessions#create'
	get 'logout' => 'sessions#destroy', as: :logout

	get 'auth/:provider/callback' => 'sessions#create'
	get 'auth/failure' => 'sessions#failure'

	resources :users, only: [:new, :create] do
		collection do
			match 'password_forgot', as: :password_forgot, via: [:get, :post]
			get 'reset_password/:token' => 'users#reset_password', as: :reset_password
		end
	end

	resources :rooms, only: [:index, :show, :create] do
		resources :messages, only: [:index, :create]

		member do
			post 'ban/:user_id', action: :ban, as: :ban
		end
	end

end