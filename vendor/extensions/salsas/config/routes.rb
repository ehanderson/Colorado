Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :salsas do
    resources :salsas, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :salsas, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :salsas, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
