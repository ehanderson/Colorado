Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :social_media_posts do
    resources :social_media_posts, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :social_media_posts, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :social_media_posts, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
