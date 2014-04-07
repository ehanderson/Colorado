Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :web_users do
    resources :web_users, :path => '', :only => [:index, :show, :create, :update]
  end

  # Admin routes
  namespace :web_users, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :web_users, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
