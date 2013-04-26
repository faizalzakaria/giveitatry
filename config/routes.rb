Giveitatry::Application.routes.draw do
  resources :images do
    collection do
      get 'viewall'
      get 'room/:id' => "room#show", :as => "room"
    end
  end

  root :to => 'images#index'

end
