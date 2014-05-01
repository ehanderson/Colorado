Refinery::Core::Engine.routes.draw do
  # Frontend routes
  namespace :leg_finders do
    resources :leg_finders, :path => '', :only => [:new, :create] do
      collection do
        get :thank_you
      end
    end
  end

  # Admin routes
  namespace :leg_finders, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}/leg_finders" do
      resources :leg_finders, :path => '' 
      resources :settings, :only => [:edit, :update]
    end
  end
end

