Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :web_users do
    resources :web_users, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :web_users, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :web_users, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
