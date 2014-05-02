Refinery::Core::Engine.routes.draw do
  # Frontend routes
  namespace :legislator_lookups do
    resources :legislator_lookups, :path => '', :only => [:new, :create] do
      collection do
        get :thank_you
      end
    end
  end

  # Admin routes
  namespace :legislator_lookups, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}/legislator_lookups" do
      resources :legislator_lookups, :path => ''
      resources :settings, :only => [:edit, :update]
    end
  end
end

